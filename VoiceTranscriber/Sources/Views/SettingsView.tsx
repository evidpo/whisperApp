import React, { useState } from 'react';
import './SettingsView.css';

const SettingsView: React.FC = () => {
  const [selectedLanguage, setSelectedLanguage] = useState('auto');
  const [modelSize, setModelSize] = useState('base');
  const [hotKeyEnabled, setHotKeyEnabled] = useState(true);
  const [autoInsertText, setAutoInsertText] = useState(false);
  const [recordingHotKey, setRecordingHotKey] = useState('cmd+shift+space');

  const languages = [
    { value: 'auto', label: 'Автоопределение' },
    { value: 'ru', label: 'Русский' },
    { value: 'en', label: 'Английский' },
    { value: 'es', label: 'Испанский' },
    { value: 'fr', label: 'Французский' },
    { value: 'de', label: 'Немецкий' },
  ];

  const modelSizes = [
    { value: 'tiny', label: 'Tiny (Быстрая, ~39MB)' },
    { value: 'base', label: 'Base (Сбалансированная, ~74MB)' },
    { value: 'small', label: 'Small (Точная, ~244MB)' },
  ];

  const handleSave = () => {
    // Здесь будет логика сохранения настроек
    console.log('Настройки сохранены:', {
      selectedLanguage,
      modelSize,
      hotKeyEnabled,
      autoInsertText,
      recordingHotKey
    });
  };

  const handleReset = () => {
    // Сброс к значениям по умолчанию
    setSelectedLanguage('auto');
    setModelSize('base');
    setHotKeyEnabled(true);
    setAutoInsertText(false);
    setRecordingHotKey('cmd+shift+space');
  };

  return (
    <div className="settings-view">
      <header className="settings-header">
        <h1>Настройки</h1>
      </header>
      
      <main className="settings-content">
        <div className="settings-group">
          <h2>Модель распознавания</h2>
          <div className="setting-item">
            <label htmlFor="model-size">Размер модели:</label>
            <select
              id="model-size"
              value={modelSize}
              onChange={(e) => setModelSize(e.target.value)}
              className="setting-select"
            >
              {modelSizes.map((model) => (
                <option key={model.value} value={model.value}>
                  {model.label}
                </option>
              ))}
            </select>
          </div>
        </div>
        
        <div className="settings-group">
          <h2>Язык</h2>
          <div className="setting-item">
            <label htmlFor="language">Язык распознавания:</label>
            <select
              id="language"
              value={selectedLanguage}
              onChange={(e) => setSelectedLanguage(e.target.value)}
              className="setting-select"
            >
              {languages.map((lang) => (
                <option key={lang.value} value={lang.value}>
                  {lang.label}
                </option>
              ))}
            </select>
          </div>
        </div>
        
        <div className="settings-group">
          <h2>Горячие клавиши</h2>
          <div className="setting-item">
            <label htmlFor="hotkey-enabled">Включить горячие клавиши:</label>
            <div className="toggle-switch">
              <input
                type="checkbox"
                id="hotkey-enabled"
                checked={hotKeyEnabled}
                onChange={(e) => setHotKeyEnabled(e.target.checked)}
              />
              <label htmlFor="hotkey-enabled" className="toggle-label">
                <span className="toggle-slider"></span>
              </label>
            </div>
          </div>
          
          <div className="setting-item">
            <label htmlFor="hotkey-combo">Комбинация клавиш:</label>
            <input
              type="text"
              id="hotkey-combo"
              value={recordingHotKey}
              onChange={(e) => setRecordingHotKey(e.target.value)}
              className="setting-input"
              disabled={!hotKeyEnabled}
            />
          </div>
        
        <div className="settings-group">
          <h2>Интеграция</h2>
          <div className="setting-item">
            <label htmlFor="auto-insert">Автоматическая вставка текста:</label>
            <div className="toggle-switch">
              <input
                type="checkbox"
                id="auto-insert"
                checked={autoInsertText}
                onChange={(e) => setAutoInsertText(e.target.checked)}
              />
              <label htmlFor="auto-insert" className="toggle-label">
                <span className="toggle-slider"></span>
              </label>
            </div>
          </div>
        </div>
      </div>
      </main>
      
      <footer className="settings-footer">
        <button className="settings-button secondary" onClick={handleReset}>
          Сбросить
        </button>
        <button className="settings-button primary" onClick={handleSave}>
          Сохранить
        </button>
      </footer>
    </div>
  );
};

export default SettingsView;