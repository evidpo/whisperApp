import Foundation
import SwiftUI

class SettingsViewModel: ObservableObject {
    @Published var settings: AppSettings
    @Published var availableModels: [WhisperModelSize] = WhisperModelSize.allCases
    @Published var availableLanguages = [
        ("auto", "Автоопределение"),
        ("ru", "Русский"),
        ("en", "English"),
        ("es", "Español"),
        ("de", "Deutsch"),
        ("fr", "Français")
    ]
    
    init(settings: AppSettings = AppSettings()) {
        self.settings = settings
    }
    
    func saveSettings() {
        // Настройки автоматически сохраняются через didSet в AppSettings
        print("Settings saved")
    }
    
    func resetToDefaults() {
        settings.selectedLanguage = "auto"
        settings.modelSize = "base"
        settings.hotKeyEnabled = true
        settings.autoInsertText = false
        settings.recordingHotKey = "cmd+shift+space"
    }
}