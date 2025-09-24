import SwiftUI

struct StatusIndicatorView: View {
    let recordingState: RecordingState
    let recordingLevel: Float
    
    var body: some View {
        VStack {
            Text(getStatusText())
                .font(.headline)
                .foregroundColor(getStatusColor())
            
            if recordingState == .recording {
                RecordingLevelIndicator(level: recordingLevel)
                    .frame(height: 20)
            }
        }
    }
    
    private func getStatusText() -> String {
        switch recordingState {
        case .idle:
            return "Готов к записи"
        case .recording:
            return "Запись..."
        case .processing:
            return "Обработка..."
        case .completed:
            return "Готово"
        case .error(let message):
            return "Ошибка: \(message)"
        }
    }
    
    private func getStatusColor() -> Color {
        switch recordingState {
        case .idle, .completed:
            return .green
        case .recording:
            return .red
        case .processing:
            return .orange
        case .error:
            return .red
        }
    }
}

struct RecordingLevelIndicator: View {
    let level: Float
    
    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 2) {
                ForEach(0..<10, id: \.self) { index in
                    let barHeight = getHeightForBar(at: index)
                    Rectangle()
                        .fill(getColorForBar(at: index))
                        .frame(height: barHeight)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .frame(height: 20)
    }
    
    private func getHeightForBar(at index: Int) -> CGFloat {
        let normalizedLevel = CGFloat(min(max(level + 40, 0), 40)) / 40 // Normalize -40dB to 0dB to 0-1 range
        let maxBarHeight = CGFloat(20)
        let barIndexFactor = CGFloat(index) / 9.0  // 0 to 1 for 10 bars
        let heightFactor = normalizedLevel * barIndexFactor
        return maxBarHeight * heightFactor
    }
    
    private func getColorForBar(at index: Int) -> Color {
        let normalizedLevel = min(max(level + 40, 0), 40) / 40 // Normalize -40dB to 0dB to 0-1 range
        let barIndexFactor = Double(index) / 9.0  // 0 to 1 for 10 bars
        let levelFactor = normalizedLevel * barIndexFactor
        
        if levelFactor > 0.7 {
            return .red
        } else if levelFactor > 0.4 {
            return .orange
        } else {
            return .green
        }
    }
}

struct StatusIndicatorView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            StatusIndicatorView(recordingState: .idle, recordingLevel: -20.0)
            StatusIndicatorView(recordingState: .recording, recordingLevel: -10.0)
            StatusIndicatorView(recordingState: .processing, recordingLevel: 0.0)
            StatusIndicatorView(recordingState: .completed, recordingLevel: 0.0)
            StatusIndicatorView(recordingState: .error("Test error"), recordingLevel: 0.0)
        }
    }
}