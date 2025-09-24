import SwiftUI

struct MainView: View {
    @StateObject var viewModel: MainViewModel
    @State private var showingSettings = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Voice Transcriber")
                .font(.title)
                .fontWeight(.bold)
            
            StatusIndicatorView(recordingState: viewModel.recordingState, recordingLevel: viewModel.recordingLevel)
            
            RecordingButton(
                isRecording: viewModel.recordingState == .recording,
                onToggle: viewModel.toggleRecording
            )
            .frame(width: 80, height: 80)
            
            ScrollView {
                Text(viewModel.transcriptionText)
                    .frame(minHeight: 150, alignment: .topLeading)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray, lineWidth: 1)
                    )
            }
            .frame(height: 150)
            
            HStack {
                Button("Копировать") {
                    viewModel.copyToClipboard()
                }
                
                Button("Очистить") {
                    viewModel.clearTranscription()
                }
                
                Button("Настройки") {
                    showingSettings = true
                }
            }
        }
        .padding()
        .sheet(isPresented: $showingSettings) {
            SettingsView()
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(viewModel: MainViewModel())
    }
}