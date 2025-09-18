import { NativeModules, Platform } from 'react-native';

// Определение типа для нативного модуля
interface AudioManagerNativeModule {
  startRecording(): Promise<{ success: boolean }>;
  stopRecording(): Promise<{ success: boolean }>;
  getRecordingLevel(): Promise<{ level: number }>;
  isRecording(): Promise<{ isRecording: boolean }>;
}

// Получение нативного модуля
const { AudioManager }: { AudioManager: AudioManagerNativeModule } = NativeModules;

// Проверка доступности модуля
if (!AudioManager) {
  console.warn('AudioManager native module is not available');
}

class AudioManagerInterface {
  /**
   * Начать запись аудио
   * @returns Promise, который разрешается при успешном начале записи
   */
  static async startRecording(): Promise<boolean> {
    if (!AudioManager) {
      throw new Error('AudioManager native module is not available');
    }
    
    try {
      const result = await AudioManager.startRecording();
      return result.success;
    } catch (error) {
      console.error('Failed to start recording:', error);
      throw error;
    }
  }

  /**
   * Остановить запись аудио
   * @returns Promise, который разрешается при успешной остановке записи
   */
  static async stopRecording(): Promise<boolean> {
    if (!AudioManager) {
      throw new Error('AudioManager native module is not available');
    }
    
    try {
      const result = await AudioManager.stopRecording();
      return result.success;
    } catch (error) {
      console.error('Failed to stop recording:', error);
      throw error;
    }
  }

  /**
   * Получить текущий уровень записи (в децибелах)
   * @returns Promise, который разрешается с уровнем записи
   */
  static async getRecordingLevel(): Promise<number> {
    if (!AudioManager) {
      throw new Error('AudioManager native module is not available');
    }
    
    try {
      const result = await AudioManager.getRecordingLevel();
      return result.level;
    } catch (error) {
      console.error('Failed to get recording level:', error);
      throw error;
    }
  }

  /**
   * Проверить, идет ли запись
   * @returns Promise, который разрешается с состоянием записи
   */
  static async isRecording(): Promise<boolean> {
    if (!AudioManager) {
      throw new Error('AudioManager native module is not available');
    }
    
    try {
      const result = await AudioManager.isRecording();
      return result.isRecording;
    } catch (error) {
      console.error('Failed to check recording state:', error);
      throw error;
    }
  }
}

export default AudioManagerInterface;