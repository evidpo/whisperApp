import Cocoa
import AVFoundation

class SystemIntegrationManager: ObservableObject {
    private let pasteboard = NSPasteboard.general
    
    // MARK: - Public Methods
    
    func copyToClipboard(text: String) {
        pasteboard.clearContents()
        pasteboard.setString(text, forType: .string)
        print("Text copied to clipboard")
    }
    
    func insertTextToActiveApp(text: String) -> Bool {
        // Проверяем разрешения на доступ к системе
        if !hasAccessibilityPermission() {
            requestAccessibilityPermission()
            return false
        }
        
        // Вставка текста в активное приложение через AppleScript
        let script = """
        tell application "System Events"
            set frontmostApplication to first application process whose frontmost is true
            set activeApp to name of frontmostApplication
            keystroke "\(text)"
        end tell
        """
        
        var error: NSDictionary?
        let result = NSAppleScript(source: script)?.executeAndReturnError(&error)
        
        if let error = error {
            print("AppleScript error: \(error)")
            return false
        }
        
        return result?.booleanValue ?? false
    }
    
    func hasAccessibilityPermission() -> Bool {
        let options = [
            kAXTrustedCheckOptionPrompt.takeRetainedValue(): false
        ] as CFDictionary
        
        return AXIsProcessTrustedWithOptions(options)
    }
    
    func requestAccessibilityPermission() {
        let options = [
            kAXTrustedCheckOptionPrompt.takeRetainedValue(): true
        ] as CFDictionary
        
        AXIsProcessTrustedWithOptions(options)
    }
    
    func getCurrentAppName() -> String? {
        guard let frontmostApp = NSWorkspace.shared.frontmostApplication else { return nil }
        return frontmostApp.localizedName
    }
}