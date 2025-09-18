import SwiftUI
import Foundation
import Combine

class MainViewModel: ObservableObject {
    @Published var recordingState: RecordingState = .idle
    @Published var transcriptionText: String = ""
    @Published var recordingLevel: Float = 0.0
    
    // Менеджеры
    private let audioManager: AudioManager
    // WhisperManager будет использоваться для транскрибации аудио
    // private let whisperManager: WhisperManager
    
    enum RecordingState {
        case idle
        case recording
        case processing
        case completed
        case error
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        audioManager = AudioManager()
        // whisperManager = WhisperManager() - будет инициализирован при необходимости
        
        // Подписываемся на изменения уровня записи в AudioManager
        audioManager.$audioLevel
            .sink { [weak self] level in
                DispatchQueue.main.async {
                    self?.recordingLevel = level
                }
            }
            .store(in: &cancellables)
        
        // Подписываемся на изменения состояния записи в AudioManager
        audioManager.$isRecording
            .sink { [weak self] isRecording in
                DispatchQueue.main.async {
                    self?.recordingState = isRecording ? .recording : .idle
                }
            .store(in: &cancellables)
    }
    
    func toggleRecording() {
        if audioManager.isRecording {
            stopRecording()
        } else {
            startRecording()
        }
    }
    
    private func startRecording() {
        // Обновляем состояние
        recordingState = .recording
        
        // Начинаем запись в AudioManager
        audioManager.startRecording()
    }
    
    private func stopRecording() {
        // Обновляем состояние
        recordingState = .processing
        
        // Останавливаем запись в AudioManager
        audioManager.stopRecording()
        
        // Здесь будет вызов whisperManager для транскрибации
        // Пример использования WhisperManager:
        /*
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self = self else { return }
            
            let whisperManager = WhisperManager()
            
            // В реальной реализации здесь будет путь к реальной модели
            let modelPath = "path/to/whisper/model.bin"
            let initializationResult = whisperManager.initializeWhisper(modelPath: modelPath)
            
            DispatchQueue.main.async {
                if initializationResult {
                    print("Whisper.cpp initialized successfully")
                    // В реальной реализации здесь будет путь к реальному аудио файлу
                    let audioPath = "path/to/audio/file.wav"
                    let transcriptionResult = whisperManager.transcribeAudio(audioPath: audioPath)
                    
                    if let transcription = transcriptionResult {
                        self.transcriptionText = transcription
                        self.recordingState = .completed
                    } else {
                        self.recordingState = .error
                    }
                } else {
                    self.recordingState = .error
                }
            }
        }
        */
    }
    
    func copyToClipboard() {
        // Копирование текста в буфер обмена
        #if os(iOS)
        if let pasteboard = UIPasteboard.general {
            pasteboard.string = transcriptionText
        }
        #endif
    }
    
    func clearTranscription() {
        // Очистка транскрибированного текста
        transcriptionText = ""
    }
}