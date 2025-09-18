# Extensions

## String+Extensions.swift

Полезные расширения для строк, которые могут быть использованы в проекте.

### Базовая структура:

```swift
import Foundation

extension String {
    /// Форматирование времени в строку
    func formattedTime() -> String {
        // Реализация форматирования времени
        return self
    }
    
    /// Очистка текста от лишних символов
    func cleaned() -> String {
        // Реализация очистки текста
        return self
    }
    
    /// Проверка, является ли строка пустой или содержит только пробелы
    var isBlank: Bool {
        return trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
```

## View+Extensions.swift

Кастомные модификаторы SwiftUI для упрощения создания интерфейса.

### Базовая структура:

```swift
import SwiftUI

extension View {
    /// Добавление тени к представлению
    func customShadow() -> some View {
        self.shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
    }
    
    /// Стиль для кнопок приложения
    func appButtonStyle() -> some View {
        self.buttonStyle(AppButtonStyle())
    }
    
    /// Скрытие элемента при определенном условии
    @ViewBuilder
    func hidden(_ shouldHide: Bool) -> some View {
        if shouldHide {
            self.hidden()
        } else {
            self
        }
    }
}

/// Стиль кнопки для приложения
struct AppButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
}