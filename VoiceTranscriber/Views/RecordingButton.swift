import SwiftUI

struct RecordingButton: View {
    let isRecording: Bool
    let onToggle: () -> Void
    
    var body: some View {
        Button(action: onToggle) {
            ZStack {
                Circle()
                    .fill(getButtonColor())
                    .frame(width: 80, height: 80)
                
                Image(systemName: getIconName())
                    .foregroundColor(.white)
                    .font(.title2)
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    private func getButtonColor() -> Color {
        switch isRecording {
        case true:
            return .red
        case false:
            return .blue
        }
    }
    
    private func getIconName() -> String {
        switch isRecording {
        case true:
            return "stop.fill"
        case false:
            return "mic.fill"
        }
    }
}

struct RecordingButton_Previews: PreviewProvider {
    static var previews: some View {
        RecordingButton(isRecording: false, onToggle: {})
            .previewDisplayName("Idle")
        
        RecordingButton(isRecording: true, onToggle: {})
            .previewDisplayName("Recording")
    }
}