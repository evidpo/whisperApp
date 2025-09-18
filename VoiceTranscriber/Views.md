# View Components

## MainView.swift

Основной интерфейс приложения, содержащий кнопку записи, индикатор состояния и поле результата.

### Базовая структура:

```swift
import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = MainViewModel()
    
    var body: some View {
        // Основной интерфейс с кнопкой записи, индикатором состояния и полем результата
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
```

## SettingsView.swift

Окно настроек приложения с выбором модели Whisper, языка и горячих клавиш.

### Базовая структура:

```swift
import SwiftUI

struct SettingsView: View {
    @StateObject private var viewModel = SettingsViewModel()
    
    var body: some View {
        // Интерфейс настроек с выбором модели, языка и горячих клавиш
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
```

## RecordingButton.swift

Кастомная кнопка записи с анимациями, изменяющая внешний вид в зависимости от состояния.

### Базовая структура:

```swift
import SwiftUI

struct RecordingButton: View {
    let isRecording: Bool
    let action: () -> Void
    
    var body: some View {
        // Круглая кнопка с иконкой микрофона/стоп, меняющая цвет при записи
    }
}

struct RecordingButton_Previews: PreviewProvider {
    static var previews: some View {
        RecordingButton(isRecording: false) {
            // Действие
        }
    }
}
```

## StatusIndicator.swift

Визуальный индикатор состояния приложения с текстовым описанием и графическими элементами.

### Базовая структура:

```swift
import SwiftUI

struct StatusIndicator: View {
    let state: RecordingState
    
    var body: some View {
        // Индикатор состояния с текстом и визуальными элементами
    }
}

struct StatusIndicator_Previews: PreviewProvider {
    static var previews: some View {
        StatusIndicator(state: .idle)
    }
}