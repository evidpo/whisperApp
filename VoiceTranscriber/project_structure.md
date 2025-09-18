# Структура проекта VoiceTranscriber

## Общая структура проекта

```
VoiceTranscriber/
├── VoiceTranscriber.xcodeproj
├── VoiceTranscriber/
│   ├── App/
│   │   ├── VoiceTranscriberApp.swift       // Точка входа
│   │   └── ContentView.swift               // Главный контейнер
│   ├── Views/
│   │   ├── MainView.swift                  // Основной интерфейс
│   │   ├── SettingsView.swift              // Настройки
│   │   ├── RecordingButton.swift           // Кнопка записи
│   │   └── StatusIndicator.swift           // Индикатор состояния
│   ├── ViewModels/
│   │   ├── MainViewModel.swift             // Основная логика UI
│   │   └── SettingsViewModel.swift         // Логика настроек
│   ├── Models/
│   │   ├── RecordingState.swift            // Состояния записи
│   │   ├── AppSettings.swift               // Настройки приложения
│   │   └── WhisperModel.swift              // Модели Whisper
│   ├── Managers/
│   │   ├── AudioManager.swift              // Работа с микрофоном
│   │   ├── WhisperManager.swift            // Транскрипция
│   │   ├── HotKeyManager.swift             // Горячие клавиши
│   │   └── SystemIntegrationManager.swift  // Вставка текста
│   ├── Extensions/
│   │   ├── String+Extensions.swift
│   │   └── View+Extensions.swift
│   ├── Resources/
│   │   ├── Info.plist
│   │   ├── Assets.xcassets
│   │   └── whisper-models/                 // Папка для AI моделей
│   └── Localizable.strings
├── VoiceTranscriber-Bridging-Header.h      // Для whisper.cpp
└── README.md
```

## Подробное описание компонентов

### 1. Точка входа и основной контейнер
- `VoiceTranscriberApp.swift` - основной класс приложения, использующий SwiftUI @main
- `ContentView.swift` - главный контейнер, который будет содержать основной интерфейс

### 2. View компоненты
- `MainView.swift` - основной интерфейс приложения с кнопкой записи, индикатором состояния и полем результата
- `SettingsView.swift` - окно настроек с выбором модели, языка и горячих клавиш
- `RecordingButton.swift` - кастомная кнопка записи с анимациями
- `StatusIndicator.swift` - визуальный индикатор состояния приложения

### 3. ViewModels
- `MainViewModel.swift` - основная логика UI, управление состояниями и координация между менеджерами
- `SettingsViewModel.swift` - логика управления настройками приложения

### 4. Модели данных
- `RecordingState.swift` - перечисление состояний записи (idle, recording, processing, completed, error)
- `AppSettings.swift` - модель настроек приложения с использованием @UserDefault
- `WhisperModel.swift` - перечисление доступных моделей Whisper (tiny, base, small)

### 5. Менеджеры
- `AudioManager.swift` - управление записью аудио через AVAudioEngine
- `WhisperManager.swift` - интеграция с whisper.cpp для транскрипции
- `HotKeyManager.swift` - регистрация и обработка глобальных горячих клавиш
- `SystemIntegrationManager.swift` - автоматическая вставка текста через Accessibility API

### 6. Расширения
- `String+Extensions.swift` - полезные расширения для строк
- `View+Extensions.swift` - кастомные модификаторы SwiftUI

### 7. Ресурсы
- `Info.plist` - конфигурационный файл с разрешениями и настройками
- `Assets.xcassets` - ассеты приложения (изображения, цвета)
- `whisper-models/` - папка для хранения моделей Whisper
- `Localizable.strings` - файлы локализации

### 8. Другие файлы
- `VoiceTranscriber-Bridging-Header.h` - заголовочный файл для связи Swift с C/C++ библиотеками whisper.cpp
- `README.md` - документация проекта

## Технические требования

- **Платформа**: macOS 13.0+
- **Язык программирования**: Swift
- **UI Framework**: SwiftUI
- **Архитектура**: MVVM
- **Dependency Manager**: Swift Package Manager
- **AI модель**: whisper.cpp (локально)

## Внешние зависимости

```swift
dependencies: [
    .package(url: "https://github.com/ggerganov/whisper.cpp", branch: "master")
]