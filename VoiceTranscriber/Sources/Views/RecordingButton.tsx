import React from 'react';
import './RecordingButton.css';

interface RecordingButtonProps {
  isRecording: boolean;
  isProcessing?: boolean;
  onPress: () => void;
}

const RecordingButton: React.FC<RecordingButtonProps> = ({
  isRecording,
  isProcessing = false,
  onPress
}) => {
  // Определяем состояние кнопки
  const getButtonState = () => {
    if (isProcessing) return 'processing';
    if (isRecording) return 'recording';
    return 'idle';
  };

  const buttonState = getButtonState();

  return (
    <button
      className={`recording-button ${buttonState}`}
      onClick={onPress}
      aria-label={isRecording ? "Остановить запись" : "Начать запись"}
    >
      <div className="button-content">
        {buttonState === 'idle' && (
          <svg width="32" height="32" viewBox="0 0 24 24" fill="none">
            <path 
              d="M12 14C13.66 14 15 12.66 15 11V5C15 3.34 13.66 2 12 2C10.34 2 9 3.34 9 5V11C9 12.6 10.34 14 12 14Z" 
              fill="currentColor"
            />
            <path 
              d="M17 11C17 13.76 14.76 16 12 16C9.24 16 7 13.76 7 11H5C5 14.53 7.61 17.43 11 17.92V21H13V17.92C16.39 17.43 19 14.53 19 11H17Z" 
              fill="currentColor"
            />
          </svg>
        )}
        
        {buttonState === 'recording' && (
          <div className="recording-icon">
            <div className="pulse-circle"></div>
          </div>
        )}
        
        {buttonState === 'processing' && (
          <div className="processing-icon">
            <div className="spinner"></div>
          </div>
        )}
      </div>
    </button>
  );
};

export default RecordingButton;