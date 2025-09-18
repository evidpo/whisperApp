import React from 'react';
import './StatusIndicator.css';

interface StatusIndicatorProps {
  state: 'idle' | 'recording' | 'processing' | 'completed' | 'error';
  audioLevel?: number; // Уровень аудио в децибелах (-80 до 0)
}

const StatusIndicator: React.FC<StatusIndicatorProps> = ({ state, audioLevel = -80 }) => {
  // Определяем цвета для 10 полосок в зависимости от состояния
  const getBarColors = () => {
    switch (state) {
      case 'idle':
        return Array(10).fill('#e0e0e0');
      case 'recording':
        return Array(10).fill('#ff5252');
      case 'processing':
        return Array(10).fill('#448aff');
      case 'completed':
        return Array(10).fill('#4caf50');
      case 'error':
        return Array(10).fill('#ff4081');
      default:
        return Array(10).fill('#e0e0e0');
    }
  };

  // Нормализуем уровень аудио (-80 до 0) в диапазон (0 до 1)
  const normalizedLevel = Math.min(1, Math.max(0, (audioLevel + 80) / 80));
  
  // Определяем, сколько полосок должно быть активно
  const activeBars = Math.ceil(normalizedLevel * 10);

  const barColors = getBarColors();

  return (
    <div className="status-indicator">
      <div className="status-text">
        {state === 'idle' && 'Готов к записи'}
        {state === 'recording' && 'Запись...'}
        {state === 'processing' && 'Обработка...'}
        {state === 'completed' && 'Готово'}
        {state === 'error' && 'Ошибка'}
      </div>
      <div className="indicator-bars">
        {barColors.map((color, index) => (
          <div
            key={index}
            className="indicator-bar"
            style={{
              backgroundColor: color,
              height: `${Math.max(4, (index + 1) * 3)}px`, // Разная высота для визуального эффекта
              opacity: state === 'recording' && index < activeBars ? 1 :
                      state !== 'recording' ? 1 : 0.3,
            }}
          />
        ))}
      </div>
    </div>
  );
};

export default StatusIndicator;