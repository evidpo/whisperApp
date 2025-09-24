import SwiftUI

@main
struct VoiceTranscriberApp: App {
    @StateObject private var settings = AppSettings()
    
    var body: some Scene {
        WindowGroup {
            MainView(viewModel: MainViewModel(settings: settings))
                .onAppear {
                    // Настройка горячей клавиши при запуске приложения
                    let mainViewModel = MainViewModel(settings: settings)
                    mainViewModel.setupHotKey()
                }
        }
        .windowStyle(HiddenTitleBarWindowStyle())
        .windowResizability(.contentSize)
    }
}