# App Components

## VoiceTranscriberApp.swift

Точка входа в приложение VoiceTranscriber. Этот файл содержит основной класс приложения, помеченный аннотацией @main.

### Базовая структура:

```swift
import SwiftUI

@main
struct VoiceTranscriberApp: App {
    // Инициализация основных компонентов приложения
    var body: some Scene {
        // Определение сцен приложения
    }
}
```

## ContentView.swift

Главный контейнер приложения, который отображает основной интерфейс.

### Базовая структура:

```swift
import SwiftUI

struct ContentView: View {
    var body: some View {
        // Основной контейнер для отображения UI
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}