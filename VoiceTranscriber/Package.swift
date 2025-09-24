// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "VoiceTranscriber",
    platforms: [
        .macOS(.v13)
    ],
    products: [
        .executable(
            name: "VoiceTranscriber",
            targets: ["VoiceTranscriber"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/ggerganov/whisper.cpp", branch: "master")
    ],
    targets: [
        .executableTarget(
            name: "VoiceTranscriber",
            dependencies: [
                .product(name: "whisper", package: "whisper.cpp")
            ],
            path: ".",
            sources: [
                "App/VoiceTranscriberApp.swift",
                "ViewModels/MainViewModel.swift",
                "ViewModels/SettingsViewModel.swift",
                "Models/RecordingState.swift",
                "Models/AppSettings.swift",
                "Models/WhisperModel.swift",
                "Managers/AudioManager.swift",
                "Managers/WhisperManager.swift",
                "Managers/HotKeyManager.swift",
                "Managers/SystemIntegrationManager.swift",
                "Views/MainView.swift",
                "Views/SettingsView.swift",
                "Views/RecordingButton.swift",
                "Views/StatusIndicator.swift"
            ],
            swiftSettings: [
                .define("WHISPER_METAL")
            ]
        )
    ]
)