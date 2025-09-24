import SwiftUI
import Combine
import AVFoundation

class MainViewModel: ObservableObject {
    @Published var recordingState: RecordingState = .idle
    @Published var transcriptionText: String = ""
    @Published var recordingLevel: Float = 0.0
    
    // Менеджеры
    private let audioManager: AudioManager
    private let whisperManager: WhisperManager
    private let hotKeyManager: HotKeyManager
    private let systemIntegrationManager: SystemIntegrationManager
    private let settings: AppSettings
    
    private var cancellables = Set<AnyCancellable>()
    
    init(settings: AppSettings = AppSettings()) {
        self.settings = settings
        self.audioManager = AudioManager()
        self.whisperManager = WhisperManager()
        self.hotKeyManager = HotKeyManager()
        self.systemIntegrationManager = SystemIntegrationManager()
        
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
        
        // Получаем путь к последнему записанному файлу
        if let lastRecordingPath = audioManager.getLastRecordingPath() {
            // Инициализируем whisper с выбранной моделью
            let modelPath = getModelPath()
            let initializationResult = whisperManager.initializeWhisper(modelPath: modelPath)
            
            if initializationResult {
                print("Whisper.cpp initialized successfully")
                
                // Выполняем транскрибацию в фоновом потоке
                DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                    guard let self = self else { return }
                    
                    let transcriptionResult = whisperManager.transcribeAudio(audioPath: lastRecordingPath)
                    
                    DispatchQueue.main.async {
                        if let transcription = transcriptionResult {
                            self.transcriptionText = transcription
                            self.recordingState = .completed
                            
                            // Если включена автовставка, вставляем текст в активное приложение
                            if self.settings.autoInsertText {
                                self.systemIntegrationManager.insertTextToActiveApp(text: transcription)
                            }
                        } else {
                            self.recordingState = .error("Failed to transcribe audio")
                        }
                    }
                }
            } else {
                recordingState = .error("Failed to initialize Whisper model")
            }
        } else {
            recordingState = .error("No recording file found")
        }
    }
    
    func copyToClipboard() {
        systemIntegrationManager.copyToClipboard(text: transcriptionText)
    }
    
    func clearTranscription() {
        transcriptionText = ""
    }
    
    func setupHotKey() {
        // Настройка горячей клавиши для переключения записи
        // Комбинация по умолчанию: ⌘⇧Пробел
        hotKeyManager.registerHotKey(UInt16(kVK_Space), modifiers: UInt32(cmdKey | shiftKey)) { [weak self] in
            self?.toggleRecording()
        }
    }
    
    private func getModelPath() -> String {
        // Возвращаем путь к выбранной модели
        // В реальной реализации нужно реализовать загрузку и хранение моделей
        let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let modelName = settings.modelSize
        let modelFileName = "ggml-\(modelName).bin"
        return documentsPath.appendingPathComponent("whisper-models").appendingPathComponent(modelFileName).path
    }
}

// MARK: - Extensions
extension MainViewModel {
    func requestMicrophonePermission() async -> Bool {
        switch AVCaptureDevice.authorizationStatus(for: .audio) {
        case .authorized:
            return true
        case .notDetermined:
            return await AVCaptureDevice.requestAccess(for: .audio)
        default:
            return false
        }
    }
}