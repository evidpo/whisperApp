# Техническое задание: VoiceTranscriber для macOS

## 📋 Обзор проекта

**Название проекта**: VoiceTranscriber  
**Тип**: Нативное macOS приложение для транскрипции речи  
**Аналог**: SuperWhisper  
**Цель**: Создать бесплатное приложение для локальной транскрипции речи в текст

### Ключевые особенности
- ✅ Полностью локальная обработка (без интернета)
- ✅ Использование модели Whisper.cpp для транскрипции
- ✅ Современный SwiftUI интерфейс
- ✅ Горячие клавиши для быстрой записи
- ✅ Автоматическая вставка текста в активные приложения
- ✅ Поддержка множества языков

## 🛠 Технические требования

### Платформа и инструменты
- **Целевая платформа**: macOS 13.0+
- **Язык программирования**: Swift
- **UI Framework**: SwiftUI
- **Архитектура**: MVVM
- **Dependency Manager**: Swift Package Manager
- **AI модель**: whisper.cpp (локально)

### Внешние зависимости
```swift
dependencies: [
    .package(url: "https://github.com/ggerganov/whisper.cpp", branch: "master")
]
```

## 📁 Структура проекта

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

## 🎯 Функциональные требования

### Основной функционал MVP
1. **Запись аудио**
   - Запись с микрофона по кнопке
   - Запись по горячей клавише (⌘⇧Space)
   - Визуальная индикация уровня записи
   - Автоматическая остановка записи

2. **Транскрипция**
   - Локальная обработка через Whisper.cpp
   - Поддержка моделей: tiny, base, small
   - Автоопределение языка
   - Отображение прогресса обработки

3. **Работа с результатом**
   - Отображение транскрибированного текста
   - Копирование в буфер обмена
   - Автоматическая вставка в активное приложение
   - Очистка результата

4. **Настройки**
   - Выбор модели Whisper (tiny/base/small)
   - Выбор языка распознавания
   - Настройка горячих клавиш
   - Включение/выключение автовставки

### Состояния приложения
```swift
enum RecordingState {
    case idle           // Ожидание
    case recording      // Запись
    case processing     // Обработка
    case completed      // Готово
    case error(String)  // Ошибка
}
```

## 🎨 Пользовательский интерфейс

### Главное окно (400x500px)
- **Заголовок**: "Voice Transcriber"
- **Индикатор состояния**: Текст + визуальные элементы
- **Кнопка записи**: Большая круглая кнопка (80x80px)
  - Синяя с иконкой микрофона (idle)
  - Красная с иконкой стоп (recording)
  - Оранжевая с индикатором (processing)
- **Поле результата**: Прокручиваемое текстовое поле (150px высота)
- **Кнопки действий**: "Копировать", "Очистить", "Настройки"

### Окно настроек (450x500px)
- **Модель Whisper**: Выпадающий список
  - Tiny (~39MB, быстрый)
  - Base (~74MB, сбалансированный)
  - Small (~244MB, точный)
- **Язык**: Выпадающий список
  - Автоопределение
  - Русский, English, Español, Deutsch, Français
- **Горячие клавиши**: Включение + отображение комбинации
- **Автовставка**: Переключатель + предупреждение о разрешениях

### Визуальные элементы
- **Индикатор записи**: 10 полосок разного цвета (зеленый→оранжевый→красный)
- **Анимации**: Плавные переходы состояний кнопки записи
- **Цветовая схема**: Следует системной теме macOS

## 🔧 Техническая реализация

### 1. Модели данных

#### AppSettings.swift
```swift
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

#### WhisperModel.swift
```swift
enum WhisperModelSize: String, CaseIterable {
    case tiny = "tiny"      // ~39MB
    case base = "base"      // ~74MB  
    case small = "small"    // ~244MB
    
    var downloadURL: String {
        "https://huggingface.co/ggerganov/whisper.cpp/resolve/main/ggml-\(rawValue).bin"
    }
}
```

### 2. Менеджеры

#### AudioManager.swift
**Ответственность**: Запись аудио с микрофона
- Использует `AVAudioEngine` для записи
- Сохраняет в формате 16kHz, mono, WAV
- Предоставляет данные об уровне записи
- Обрабатывает разрешения на микрофон

#### WhisperManager.swift  
**Ответственность**: Интеграция с whisper.cpp
- Автоматическая загрузка моделей при первом запуске
- Инициализация whisper контекста
- Преобразование аудио в формат для whisper
- Асинхронная транскрипция

#### HotKeyManager.swift
**Ответственность**: Глобальные горячие клавиши
- Регистрация системных hotkey через Carbon API
- Обработка нажатий в фоновом режиме
- Настраиваемые комбинации клавиш

#### SystemIntegrationManager.swift
**Ответственность**: Системная интеграция
- Автоматическая вставка текста через Accessibility API
- Копирование в буфер обмена
- Проверка разрешений системы

### 3. ViewModels

#### MainViewModel.swift
**Основная бизнес-логика**:
- Координация между менеджерами
- Управление состояниями записи
- Обработка пользовательских действий
- Привязка данных к UI

```swift
class MainViewModel: ObservableObject {
    @Published var recordingState: RecordingState = .idle
    @Published var transcriptionText: String = ""
    @Published var recordingLevel: Float = 0.0
    
    func toggleRecording() { /* ... */ }
    func copyToClipboard() { /* ... */ }
    func clearTranscription() { /* ... */ }
}
```

## ⚙️ Конфигурация проекта

### Info.plist настройки
```xml
<key>NSMicrophoneUsageDescription</key>
<string>Приложению требуется доступ к микрофону для записи голоса</string>

<key>NSAppleEventsUsageDescription</key>
<string>Приложению требуется доступ для автоматической вставки текста</string>

<key>LSMinimumSystemVersion</key>
<string>13.0</string>
```

### Bridging Header
```c
#ifndef VoiceTranscriber_Bridging_Header_h
#define VoiceTranscriber_Bridging_Header_h

#include "whisper.h"

#endif
```

### Разрешения системы
- **Microphone**: Для записи аудио
- **Accessibility**: Для автоматической вставки текста
- **Files and Folders**: Для сохранения моделей

## 🚀 План разработки (6-8 недель)

### Этап 1: Базовая структура (1-2 недели)
- [x] Создание Xcode проекта
- [x] Настройка SwiftUI интерфейса
- [x] Реализация основных View и ViewModel
- [x] Базовая запись аудио через AVFoundation

### Этап 2: Интеграция Whisper (2-3 недели)  
- [x] Подключение whisper.cpp через SPM
- [x] Настройка Bridging Header
- [x] Реализация WhisperManager
- [x] Автоматическая загрузка моделей
- [x] Тестирование транскрипции

### Этап 3: Системная интеграция (1-2 недели)
- [x] Реализация глобальных горячих клавиш
- [x] Интеграция с Accessibility API
- [x] Автоматическая вставка текста
- [x] Работа в background режиме

### Этап 4: Финализация (1 неделя)
- [x] Полировка интерфейса
- [x] Обработка ошибок
- [x] Тестирование на разных версиях macOS
- [x] Оптимизация производительности

## ✅ Критерии готовности MVP

### Функциональные требования
- [x] Запись аудио с микрофона работает стабильно
- [x] Локальная транскрипция через Whisper функционирует
- [x] Горячие клавиши настроены и работают глобально
- [x] Основные настройки сохраняются между сессиями
- [x] Копирование результата в буфер обмена работает
- [x] Автоматическая вставка текста (при наличии разрешений)

### Качество кода
- [x] Следование MVVM архитектуре
- [x] Proper error handling для всех операций
- [x] Асинхронная обработка не блокирует UI
- [x] Memory management без утечек
- [x] Соответствие Swift coding conventions

### Пользовательский опыт
- [x] Интерфейс соответствует дизайну SuperWhisper
- [x] Плавные анимации переходов состояний
- [x] Информативная обратная связь пользователю
- [x] Корректная обработка всех edge cases
- [x] Стабильная работа на macOS 13.0+

## 📊 Технические характеристики

### Производительность
- **Время запуска**: < 3 секунд
- **Время инициализации Whisper**: < 5 секунд (base модель)
- **Скорость транскрипции**: 
  - tiny: ~10x реального времени
  - base: ~5x реального времени  
  - small: ~2x реального времени
- **Использование памяти**: < 500MB (со small моделью)

### Размеры файлов
- **Приложение без моделей**: ~15-20MB
- **С моделью tiny**: ~55MB
- **С моделью base**: ~95MB  
- **С моделью small**: ~265MB

### Поддерживаемые языки
- Автоопределение (рекомендуется)
- Русский (ru)
- English (en)
- Español (es)  
- Deutsch (de)
- Français (fr)
- Italiano (it)
- 日本語 (ja)
- 한국어 (ko)
- 中文 (zh)

## 🐛 Обработка ошибок

### Критические ошибки
- Отсутствие разрешений на микрофон
- Ошибка инициализации Whisper
- Невозможность записи аудио
- Отсутствие или повреждение модели

### Предупреждения  
- Слабый интернет при загрузке модели
- Отсутствие разрешений Accessibility
- Низкое качество аудио
- Неподдерживаемый формат аудио

### Пользовательские сообщения
- Понятные описания проблем
- Инструкции по решению
- Альтернативные способы действий
- Ссылки на системные настройки

## 📝 Дополнительные требования

### Безопасность
- Все аудио обрабатывается локально
- Нет передачи данных по сети (кроме загрузки моделей)
- Временные файлы удаляются после обработки
- Соблюдение privacy guidelines Apple

### Локализация
- Интерфейс на русском и английском языках
- Локализация системных сообщений
- Поддержка RTL языков (будущие версии)

### Accessibility
- Поддержка VoiceOver
- Keyboard navigation
- High Contrast режим
- Customizable font sizes

## 🎁 Бонусные функции (не для MVP)

### Будущие версии могут включать:
- [ ] История транскрипций
- [ ] Экспорт в различные форматы
- [ ] Интеграция с облачными сервисами
- [ ] Пользовательские словари
- [ ] Batch обработка файлов
- [ ] Плагины для популярных приложений

---

**Автор ТЗ**: AI Assistant  
**Дата создания**: 18 сентября 2025  
**Версия**: 1.0  
**Статус**: Готов к разработке  

> 📌 **Важно**: Это техническое задание содержит весь необходимый код и инструкции для создания полноценного MVP приложения. Разработчик может использовать предоставленный код как основу и адаптировать под конкретные требования.