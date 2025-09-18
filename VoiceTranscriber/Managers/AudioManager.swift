import AVFoundation
import SwiftUI

class AudioManager: ObservableObject {
    @Published var isRecording = false
    @Published var audioLevel: Float = 0.0
    
    private var audioEngine: AVAudioEngine?
    private var audioFile: AVAudioFile?
    private var recordingSession: AVAudioSession?
    private var timer: Timer?
    
    enum AudioManagerError: Error {
        case permissionDenied
        case recordingFailed
        case fileCreationFailed
    }
    
    init() {
        setupAudioSession()
    }
    
    private func setupAudioSession() {
        recordingSession = AVAudioSession.sharedInstance()
        do {
            try recordingSession?.setCategory(.playAndRecord, mode: .default)
            try recordingSession?.setActive(true)
        } catch {
            print("Failed to setup audio session: \(error)")
        }
    }
    
    func startRecording() {
        // Request microphone permission
        AVAudioSession.sharedInstance().requestRecordPermission { [weak self] granted in
            DispatchQueue.main.async {
                if granted {
                    self?.startRecordingAfterPermission()
                } else {
                    print("Microphone permission denied")
                }
            }
        }
    }
    
    private func startRecordingAfterPermission() {
        do {
            // Setup audio engine
            audioEngine = AVAudioEngine()
            let inputNode = audioEngine?.inputNode
            let format = inputNode?.outputFormat(forBus: 0)
            
            // Create a format for our desired recording settings (16kHz, mono)
            let desiredFormat = AVAudioFormat(commonFormat: .pcmFormatFloat32, 
                                            sampleRate: 16000, 
                                            channels: 1, 
                                            interleaved: false)
            
            guard let format = format, let desiredFormat = desiredFormat else {
                throw AudioManagerError.recordingFailed
            }
            
            // Create a mixer node to convert format
            let mixerNode = AVAudioMixerNode()
            audioEngine?.attach(mixerNode)
            audioEngine?.connect(inputNode!, to: mixerNode, format: format)
            
            // Create file URL for saving
            let documentsPath = FileManager.default.urls(for: .documentDirectory, 
                                                       in: .userDomainMask)[0]
            let fileName = "recording_\(Date().timeIntervalSince1970).wav"
            let fileURL = documentsPath.appendingPathComponent(fileName)
            
            // Create audio file
            audioFile = try AVAudioFile(forWriting: fileURL, 
                                      settings: desiredFormat.settings)
            
            // Install tap to capture audio and monitor levels
            mixerNode.installTap(onBus: 0, 
                               bufferSize: 1024, 
                               format: desiredFormat) { [weak self] buffer, time in
                // Write buffer to file
                try? self?.audioFile?.write(from: buffer)
                
                // Calculate audio level for real-time monitoring
                let level = self?.calculateAudioLevel(buffer: buffer) ?? 0.0
                DispatchQueue.main.async {
                    self?.audioLevel = level
                }
            }
            
            // Start audio engine
            audioEngine?.prepare()
            try audioEngine?.start()
            
            isRecording = true
            print("Recording started")
            
        } catch {
            print("Failed to start recording: \(error)")
            isRecording = false
        }
    }
    
    func stopRecording() {
        audioEngine?.stop()
        audioEngine?.inputNode.removeTap(onBus: 0)
        audioEngine = nil
        audioFile = nil
        isRecording = false
        audioLevel = 0.0
        print("Recording stopped")
    }
    
    private func calculateAudioLevel(buffer: AVAudioPCMBuffer) -> Float {
        guard let channelData = buffer.floatChannelData else { return 0.0 }
        
        let channelCount = Int(buffer.format.channelCount)
        let frameLength = Int(buffer.frameLength)
        
        var level: Float = 0.0
        
        for i in 0..<channelCount {
            let data = channelData[i]
            for j in 0..<frameLength {
                level += abs(data[j])
            }
        }
        
        level = level / Float(frameLength * channelCount)
        
        // Convert to dB
        if level > 0 {
            return 20 * log10(level)
        } else {
            return -80.0 // Minimum dB level
        }
    }
}