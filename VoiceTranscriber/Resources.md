# Resources

## Info.plist

Конфигурационный файл с разрешениями и настройками приложения.

### Базовая структура:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>CFBundleDevelopmentRegion</key>
    <string>$(DEVELOPMENT_LANGUAGE)</string>
    <key>CFBundleExecutable</key>
    <string>$(EXECUTABLE_NAME)</string>
    <key>CFBundleIdentifier</key>
    <string>$(PRODUCT_BUNDLE_IDENTIFIER)</string>
    <key>CFBundleInfoDictionaryVersion</key>
    <string>6.0</string>
    <key>CFBundleName</key>
    <string>$(PRODUCT_NAME)</string>
    <key>CFBundlePackageType</key>
    <string>$(PRODUCT_BUNDLE_PACKAGE_TYPE)</string>
    <key>CFBundleShortVersionString</key>
    <string>1.0</string>
    <key>CFBundleVersion</key>
    <string>1</string>
    <key>LSMinimumSystemVersion</key>
    <string>$(MACOSX_DEPLOYMENT_TARGET)</string>
    <key>NSMicrophoneUsageDescription</key>
    <string>Приложению требуется доступ к микрофону для записи голоса</string>
    <key>NSAppleEventsUsageDescription</key>
    <string>Приложению требуется доступ для автоматической вставки текста</string>
</dict>
</plist>
```

## Assets.xcassets

Ассеты приложения (изображения, цвета, иконки).

### Структура папки:

```
Assets.xcassets/
├── AppIcon.appiconset/
│   ├── Contents.json
│   ├── app-icon-16.png
│   ├── app-icon-32.png
│   ├── app-icon-128.png
│   ├── app-icon-256.png
│   ├── app-icon-512.png
│   └── app-icon-1024.png
├── Microphone.imageset/
│   ├── Contents.json
│   ├── microphone.pdf
│   └── microphone-dark.pdf
├── Stop.imageset/
│   ├── Contents.json
│   ├── stop.pdf
│   └── stop-dark.pdf
└── Contents.json
```

## whisper-models/

Папка для хранения моделей Whisper, загружаемых при первом запуске.

### Содержимое:

```
whisper-models/
├── ggml-tiny.bin      # ~39MB
├── ggml-base.bin      # ~74MB
└── ggml-small.bin     # ~244MB
```

## Localizable.strings

Файлы локализации для поддержки нескольких языков.

### Пример структуры:

```
Localizable.strings (Русский)
Localizable.strings (English)
```

### Пример содержимого Localizable.strings:

```
/* Main View */
"main.title" = "Voice Transcriber";
"main.start_recording" = "Начать запись";
"main.stop_recording" = "Остановить запись";
"main.copy_text" = "Копировать";
"main.clear_text" = "Очистить";
"main.settings" = "Настройки";

/* Settings View */
"settings.title" = "Настройки";
"settings.model" = "Модель Whisper";
"settings.language" = "Язык";
"settings.hotkey" = "Горячая клавиша";
"settings.auto_insert" = "Автовставка";

/* Status Messages */
"status.idle" = "Готов к записи";
"status.recording" = "Запись...";
"status.processing" = "Обработка...";
"status.completed" = "Готово";
"status.error" = "Ошибка: %@";