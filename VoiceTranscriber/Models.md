# Models

## RecordingState.swift

Перечисление состояний записи аудио.

### Базовая структура:

```swift
import Foundation

enum RecordingState: Equatable {
    case idle           // Ожидание
    case recording      // Запись
    case processing     // Обработка
    case completed      // Готово
    case error(String)  // Ошибка
}
```

## AppSettings.swift

Модель настроек приложения с использованием @UserDefault для сохранения значений между сессиями.

### Базовая структура:

```swift
import SwiftUI
import Foundation

class AppSettings: ObservableObject {
    @Published @UserDefault(key: "selectedLanguage", defaultValue: "auto")
    var selectedLanguage: String
    
    @Published @UserDefault(key: "modelSize", defaultValue: "base")
    var modelSize: String
    
    @Published @UserDefault(key: "hotKeyEnabled", defaultValue: true)
    var hotKeyEnabled: Bool
    
    @Published @UserDefault(key: "autoInsertText", defaultValue: false)
    var autoInsertText: Bool
    
    @Published @UserDefault(key: "recordingHotKey", defaultValue: "cmd+shift+space")
    var recordingHotKey: String
}
```

## WhisperModel.swift

Перечисление доступных моделей Whisper с информацией о размере и URL для загрузки.

### Базовая структура:

```swift
import Foundation

enum WhisperModelSize: String, CaseIterable {
    case tiny = "tiny"      // ~39MB
    case base = "base"      // ~74MB  
    case small = "small"    // ~244MB
    
    var downloadURL: String {
        "https://huggingface.co/ggerganov/whisper.cpp/resolve/main/ggml-\(rawValue).bin"
    }
    
    var displayName: String {
        switch self {
        case .tiny:
            return "Tiny (Быстрая, ~39MB)"
        case .base:
            return "Base (Сбалансированная, ~74MB)"
        case .small:
            return "Small (Точная, ~244MB)"
        }
    }
}