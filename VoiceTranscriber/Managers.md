# Managers

## AudioManager.swift

Управление записью аудио через AVAudioEngine.

### Базовая структура:

```swift
import AVFoundation
import Foundation

class AudioManager: ObservableObject {
    private var audioEngine: AVAudioEngine?
    private var audioFile: AVAudioFile?
    
    // Делегат для передачи данных об уровне записи
    weak var delegate: AudioManagerDelegate?
    
    init() {
        // Настройка аудиосессии
    }
    
    func startRecording() throws {
        // Начало записи аудио с микрофона
    }
    
    func stopRecording() throws {
        // Остановка записи и сохранение файла
    }
    
    func requestMicrophonePermission() async -> Bool {
        // Запрос разрешения на использование микрофона
    }
}

protocol AudioManagerDelegate: AnyObject {
    func audioManager(_ manager: AudioManager, didUpdateLevel level: Float)
}
```

## WhisperManager.swift

Интеграция с whisper.cpp для транскрипции аудио.

### Базовая структура:

```swift
import Foundation

class WhisperManager: ObservableObject {
    private var whisperContext: OpaquePointer?
    
    init() {
        // Инициализация менеджера
    }
    
    func initializeModel(_ modelPath: String) throws {
        // Инициализация контекста whisper с указанной моделью
    }
    
    func transcribeAudio(_ audioPath: String) async throws -> String {
        // Транскрипция аудио файла в текст
    }
    
    func downloadModel(_ modelSize: WhisperModelSize) async throws -> String {
        // Загрузка модели Whisper при первом запуске
    }
}

// Расширения для работы с C API whisper.cpp
extension WhisperManager {
    // Вспомогательные функции для работы с whisper.cpp
}
```

## HotKeyManager.swift

Регистрация и обработка глобальных горячих клавиш.

### Базовая структура:

```swift
import Carbon
import Foundation

class HotKeyManager: ObservableObject {
    private var hotKeyRef: EventHotKeyRef?
    
    init() {
        // Инициализация менеджера горячих клавиш
    }
    
    func registerHotKey(_ keyCombo: String) throws {
        // Регистрация глобальной горячей клавиши
    }
    
    func unregisterHotKey() {
        // Отмена регистрации горячей клавиши
    }
    
    func handleHotKeyPress() {
        // Обработка нажатия горячей клавиши
    }
}
```

## SystemIntegrationManager.swift

Автоматическая вставка текста через Accessibility API.

### Базовая структура:

```swift
import Cocoa
import Foundation

class SystemIntegrationManager: ObservableObject {
    init() {
        // Инициализация менеджера системной интеграции
    }
    
    func insertText(_ text: String) throws {
        // Автоматическая вставка текста в активное приложение
    }
    
    func copyToClipboard(_ text: String) {
        // Копирование текста в буфер обмена
    }
    
    func requestAccessibilityPermission() async -> Bool {
        // Запрос разрешения на использование Accessibility API
    }
}