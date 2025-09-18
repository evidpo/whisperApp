import AVFoundation
import Foundation
import React

@objc(AudioManagerModule)
class AudioManagerModule: NSObject, RCTBridgeModule {
    static func moduleName() -> String! {
        return "AudioManager"
    }
    
    static func requiresMainQueueSetup() -> Bool {
        return true
    }
    
    private var audioManager: AudioManager?
    
    override init() {
        super.init()
        audioManager = AudioManager()
    }
    
    @objc(startRecording:rejecter:)
    func startRecording(resolve: @escaping RCTPromiseResolveBlock, reject: @escaping RCTPromiseRejectBlock) {
        audioManager?.startRecording()
        resolve(["success": true])
    }
    
    @objc(stopRecording:rejecter:)
    func stopRecording(resolve: @escaping RCTPromiseResolveBlock, reject: @escaping RCTPromiseRejectBlock) {
        audioManager?.stopRecording()
        resolve(["success": true])
    }
    
    @objc(getRecordingLevel:rejecter:)
    func getRecordingLevel(resolve: @escaping RCTPromiseResolveBlock, reject: @escaping RCTPromiseRejectBlock) {
        let level = audioManager?.audioLevel ?? 0.0
        resolve(["level": level])
    }
    
    @objc(isRecording:rejecter:)
    func isRecording(resolve: @escaping RCTPromiseResolveBlock, reject: @escaping RCTPromiseRejectBlock) {
        let isRecording = audioManager?.isRecording ?? false
        resolve(["isRecording": isRecording])
    }
}