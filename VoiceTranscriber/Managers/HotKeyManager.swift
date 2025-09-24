import Carbon
import Cocoa

class HotKeyManager: ObservableObject {
    private var hotKeyId: UInt32 = 0
    private var hotKeyCallback: ((EventHandlerCallRef?, EventRef?, UnsafeMutableRawPointer?) -> OSStatus)!
    private var isEnabled: Bool = true
    
    // MARK: - Public Methods
    
    func registerHotKey(_ keyCode: UInt16, modifiers: UInt32, handler: @escaping () -> Void) {
        unregisterHotKey()
        
        hotKeyCallback = { (nextHandler, event, userData) -> OSStatus in
            let hotKeyManager = Unmanaged<HotKeyManager>.fromOpaque(userData!).takeUnretainedValue()
            DispatchQueue.main.async {
                handler()
            }
            return noErr
        }
        
        var eventType = EventTypeSpec()
        eventType.eventClass = OSType(kEventClassKeyboard)
        eventType.eventKind = OSType(kEventHotKey)
        
        let hotKeyID = EventHotKeyID(signature: OSType("vtHK"), id: 1)
        
        let status = RegisterEventHotKey(
            keyCode,
            modifiers,
            hotKeyID,
            GetApplicationEventTarget(),
            0,
            &hotKeyCallback
        )
        
        if status == noErr {
            hotKeyId = hotKeyID.id
            print("HotKey registered successfully")
        } else {
            print("Failed to register HotKey with status: \(status)")
        }
    }
    
    func unregisterHotKey() {
        if hotKeyId != 0 {
            let hotKeyID = EventHotKeyID(signature: OSType("vtHK"), id: hotKeyId)
            UnregisterEventHotKey(hotKeyID)
            hotKeyId = 0
        }
    }
    
    func setEnabled(_ enabled: Bool) {
        isEnabled = enabled
        if enabled {
            // Re-register the hotkey
        } else {
            unregisterHotKey()
        }
    }
    
    deinit {
        unregisterHotKey()
    }
}