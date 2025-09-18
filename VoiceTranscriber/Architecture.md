# Архитектура VoiceTranscriber

## Общая архитектура

VoiceTranscriber следует архитектуре MVVM (Model-View-ViewModel), которая обеспечивает четкое разделение ответственности между компонентами пользовательского интерфейса, бизнес-логикой и данными.

## Диаграмма архитектуры

```mermaid
graph TD
    A[VoiceTranscriberApp] --> B[ContentView]
    B --> C[MainView]
    B --> D[SettingsView]
    
    C --> E[RecordingButton]
    C --> F[StatusIndicator]
    
    C --> G[MainViewModel]
    D --> H[SettingsViewModel]
    
    G --> I[AppSettings]
    G --> J[RecordingState]
    H --> I
    
    G --> K[AudioManager]
    G --> L[WhisperManager]
    G --> M[HotKeyManager]
    G --> N[SystemIntegrationManager]
    
    K --> O[Микрофон]
    L --> P[Whisper.cpp]
    M --> Q[Carbon API]
    N --> R[Accessibility API]
    
    P --> S[Модели Whisper]
    
    style A fill:#e1f5fe
    style B fill:#f3e5f5
    style C fill:#f3e5f5
    style D fill:#f3e5f5
    style E fill:#f3e5f5
    style F fill:#f3e5f5
    style G fill:#e8f5e8
    style H fill:#e8f5e8
    style I fill:#fff3e0
    style J fill:#fff3e0
    style K fill:#ffebee
    style L fill:#ffebee
    style M fill:#ffebee
    style N fill:#ffebee
```

## Описание компонентов

### Уровень приложения (App Layer)
- **VoiceTranscriberApp**: Точка входа в приложение, инициализирует основные компоненты
- **ContentView**: Главный контейнер, который отображает основной интерфейс

### Уровень представления (View Layer)
- **MainView**: Основной интерфейс с кнопкой записи, индикатором состояния и полем результата
- **SettingsView**: Окно настроек приложения
- **RecordingButton**: Кастомная кнопка записи с анимациями
- **StatusIndicator**: Визуальный индикатор состояния приложения

### Уровень ViewModel
- **MainViewModel**: Основная логика UI, управление состояниями и координация между менеджерами
- **SettingsViewModel**: Логика управления настройками приложения

### Уровень модели (Model Layer)
- **AppSettings**: Модель настроек приложения с сохранением между сессиями
- **RecordingState**: Перечисление состояний записи

### Уровень менеджеров (Manager Layer)
- **AudioManager**: Управление записью аудио через AVAudioEngine
- **WhisperManager**: Интеграция с whisper.cpp для транскрипции
- **HotKeyManager**: Регистрация и обработка глобальных горячих клавиш
- **SystemIntegrationManager**: Автоматическая вставка текста через Accessibility API

## Поток данных

1. Пользователь взаимодействует с View компонентами (MainView, SettingsView)
2. View компоненты передают действия в соответствующие ViewModel
3. ViewModel обрабатывает бизнес-логику и координирует работу менеджеров
4. Менеджеры взаимодействуют с системными API и внешними библиотеками
5. Результаты обработки передаются обратно через ViewModel в View для отображения

## Преимущества архитектуры

- **Разделение ответственности**: Каждый компонент имеет четко определенную роль
- **Тестируемость**: ViewModel могут быть протестированы независимо от View
- **Поддерживаемость**: Изменения в одном слое минимально влияют на другие слои
- **Масштабируемость**: Новые функции могут быть добавлены с минимальными изменениями в существующем коде