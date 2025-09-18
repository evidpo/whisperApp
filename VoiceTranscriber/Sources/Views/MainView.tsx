import React, { useState, useRef, useEffect } from 'react';
import StatusIndicator from './StatusIndicator';
import RecordingButton from './RecordingButton';
import AudioManager from '../Managers/AudioManager';
import './MainView.css';

const MainView: React.FC = () => {
  const [recordingState, setRecordingState] = useState<'idle' | 'recording' | 'processing' | 'completed' | 'error'>('idle');
  const [transcriptionText, setTranscriptionText] = useState('');
  const [audioLevel, setAudioLevel] = useState<number>(-80); // Уровень аудио в децибелах
  const textareaRef = useRef<HTMLTextAreaElement>(null);
  const levelIntervalRef = useRef<NodeJS.Timeout | null>(null);

  const handleRecordingToggle = async () => {
    if (recordingState === 'idle') {
      try {
        // Начинаем запись через AudioManager
        await AudioManager.startRecording();
        setRecordingState('recording');
        
        // Начинаем отслеживание уровня аудио
        startLevelMonitoring();
      } catch (error) {
        console.error('Failed to start recording:', error);
        setRecordingState('error');
      }
    } else if (recordingState === 'recording') {
      try {
        // Останавливаем отслеживание уровня аудио
        stopLevelMonitoring();
        
        // Останавливаем запись через AudioManager
        await AudioManager.stopRecording();
        setRecordingState('processing');
        
        // Здесь будет логика начала обработки
        // Имитация обработки
        setTimeout(() => {
          setTranscriptionText(prev => prev + '\nПример транскрибированного текста после обработки аудио.');
          setRecordingState('completed');
        }, 2000);
      } catch (error) {
        console.error('Failed to stop recording:', error);
        setRecordingState('error');
      }
    }
  };
  
  const startLevelMonitoring = () => {
    // Останавливаем предыдущий интервал, если он есть
    if (levelIntervalRef.current) {
      clearInterval(levelIntervalRef.current);
    }
    
    // Создаем новый интервал для отслеживания уровня аудио
    levelIntervalRef.current = setInterval(async () => {
      try {
        const level = await AudioManager.getRecordingLevel();
        setAudioLevel(level);
      } catch (error) {
        console.error('Failed to get recording level:', error);
      }
    }, 100); // Обновляем каждые 100 мс для плавного отображения
  };
  
  const stopLevelMonitoring = () => {
    if (levelIntervalRef.current) {
      clearInterval(levelIntervalRef.current);
      levelIntervalRef.current = null;
      setAudioLevel(-80); // Сбрасываем уровень аудио
    }
  };
  
  // Очищаем интервал при размонтировании компонента
  useEffect(() => {
    return () => {
      if (levelIntervalRef.current) {
        clearInterval(levelIntervalRef.current);
      }
    };
  }, []);

  const handleCopyToClipboard = () => {
    if (textareaRef.current) {
      textareaRef.current.select();
      document.execCommand('copy');
    }
  };

  const handleClearText = () => {
    setTranscriptionText('');
  };

  const handleOpenSettings = () => {
    // Здесь будет логика открытия окна настроек
    console.log('Открытие настроек');
  };

  return (
    <div className="main-view">
      <header className="main-header">
        <h1>Voice Transcriber</h1>
      </header>
      
      <main className="main-content">
        <StatusIndicator state={recordingState} />
        
        <div className="recording-section">
          <RecordingButton 
            isRecording={recordingState === 'recording'} 
            isProcessing={recordingState === 'processing'}
            onClick={handleRecordingToggle}
          />
        </div>
        
        <div className="transcription-section">
          <textarea
            ref={textareaRef}
            className="transcription-text"
            value={transcriptionText}
            onChange={(e) => setTranscriptionText(e.target.value)}
            placeholder="Транскрибированный текст будет отображаться здесь..."
          />
        </div>
        
        <div className="action-buttons">
          <button className="action-button" onClick={handleCopyToClipboard}>
            Копировать
          </button>
          <button className="action-button" onClick={handleClearText}>
            Очистить
          </button>
          <button className="action-button" onClick={handleOpenSettings}>
            Настройки
          </button>
        </div>
      </main>
    </div>
  );
};

export default MainView;