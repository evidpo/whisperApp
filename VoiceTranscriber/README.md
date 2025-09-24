# VoiceTranscriber

VoiceTranscriber - это нативное macOS приложение для локальной транскрипции речи в текст с использованием модели Whisper.cpp.

## Особенности

- ✅ Полностью локальная обработка (без интернета)
- ✅ Использование модели Whisper.cpp для транскрипции
- ✅ Современный SwiftUI интерфейс
- ✅ Горячие клавиши для быстрой записи
- ✅ Автоматическая вставка текста в активные приложения
- ✅ Поддержка множества языков

## Требования

- macOS 13.0 или выше
- Xcode 14.0 или выше

## Установка

1. Клонируйте репозиторий:

```bash
git clone https://github.com/your-username/VoiceTranscriber.git
```

2. Откройте проект в Xcode:

```bash
cd VoiceTranscriber
open VoiceTranscriber.xcodeproj
```

3. Установите зависимости через Swift Package Manager (Xcode сделает это автоматически)

## Использование

1. Запустите приложение
2. Нажмите на кнопку записи или используйте горячую клавишу (⌘⇧Пробел)
3. Говорите в микрофон
4. После остановки записи текст будет автоматически транскрибирован
5. Скопируйте или вставьте текст в нужное место

## Структура проекта

```
VoiceTranscriber/
├── App/
│   └── VoiceTranscriberApp.swift       // Точка входа
├── Views/
│   ├── MainView.swift                  // Основной интерфейс
│   ├── SettingsView.swift              // Настройки
│   ├── RecordingButton.swift           // Кнопка записи
│   └── StatusIndicator.swift           // Индикатор состояния
├── ViewModels/
│   ├── MainViewModel.swift             // Основная логика UI
│   └── SettingsViewModel.swift         // Логика настроек
├── Models/
│   ├── RecordingState.swift            // Состояния записи
│   ├── AppSettings.swift               // Настройки приложения
│   └── WhisperModel.swift              // Модели Whisper
├── Managers/
│   ├── AudioManager.swift              // Работа с микрофоном
│   ├── WhisperManager.swift            // Транскрипция
│   ├── HotKeyManager.swift             // Горячие клавиши
│   └── SystemIntegrationManager.swift  // Вставка текста
├── Resources/
│   ├── Info.plist
│   └── Assets.xcassets
└── VoiceTranscriber-Bridging-Header.h  // Для whisper.cpp
```

## Настройки

Приложение позволяет настраивать:

- Модель Whisper (tiny, base, small)
- Язык распознавания
- Горячие клавиши
- Автовставку текста

## Безопасность

- Все аудио обрабатывается локально
- Нет передачи данных по сети (кроме загрузки моделей)
- Временные файлы удаляются после обработки

## Лицензия

MIT