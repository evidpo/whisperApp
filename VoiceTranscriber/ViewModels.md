# ViewModels

## MainViewModel.swift

Основная логика пользовательского интерфейса, управление состояниями и координация между менеджерами.

### Базовая структура:

```swift
import SwiftUI
import Foundation

class MainViewModel: ObservableObject {
    @Published var recordingState: RecordingState = .idle
    @Published var transcriptionText: String = ""
    @Published var recordingLevel: Float = 0.0
    
    // Менеджеры
    private let audioManager: AudioManager
    private let whisperManager: WhisperManager
    private let systemIntegrationManager: SystemIntegrationManager
    
    init() {
        // Инициализация менеджеров
    }
    
    func toggleRecording() {
        // Переключение состояния записи
    }
    
    func copyToClipboard() {
        // Копирование текста в буфер обмена
    }
    
    func clearTranscription() {
        // Очистка транскрибированного текста
    }
}
```

## SettingsViewModel.swift

Логика управления настройками приложения.

### Базовая структура:

```swift
import SwiftUI
import Foundation

class SettingsViewModel: ObservableObject {
    @Published var settings: AppSettings
    
    init() {
        // Инициализация настроек
    }
    
    func saveSettings() {
        // Сохранение настроек
    }
    
    func resetSettings() {
        // Сброс настроек к значениям по умолчанию
    }
}