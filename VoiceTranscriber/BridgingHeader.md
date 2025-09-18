# Bridging Header

## VoiceTranscriber-Bridging-Header.h

Заголовочный файл для связи Swift с C/C++ библиотеками whisper.cpp.

### Базовая структура:

```c
#ifndef VoiceTranscriber_Bridging_Header_h
#define VoiceTranscriber_Bridging_Header_h

// Подключение заголовочных файлов whisper.cpp
#include "whisper.h"

// Дополнительные заголовочные файлы, если необходимы
// #include "other_library.h"

#endif /* VoiceTranscriber_Bridging_Header_h */
```

### Назначение:

Bridging Header необходим для использования C/C++ библиотеки whisper.cpp в Swift коде. Он позволяет импортировать функции и типы данных из C/C++ в Swift.

### Подключение библиотеки:

1. Добавление через Swift Package Manager:
   ```swift
   dependencies: [
       .package(url: "https://github.com/ggerganov/whisper.cpp", branch: "master")
   ]
   ```

2. Настройка в Xcode:
   - TARGETS → Build Settings → Objective-C Bridging Header
   - Установить путь к файлу: `VoiceTranscriber/VoiceTranscriber-Bridging-Header.h`

### Использование в Swift коде:

После настройки Bridging Header, функции whisper.cpp становятся доступны в Swift коде:

```swift
import Foundation

class WhisperManager {
    func initializeWhisper() {
        // Использование функций из whisper.h
        // let context = whisper_init_from_file("path/to/model.bin")
    }
}