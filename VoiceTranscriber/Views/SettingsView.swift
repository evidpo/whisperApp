import SwiftUI

struct SettingsView: View {
    @StateObject var viewModel = SettingsViewModel()
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Модель Whisper")) {
                    Picker("Модель", selection: $viewModel.settings.modelSize) {
                        ForEach(viewModel.availableModels, id: \.self) { model in
                            Text(model.displayName).tag(model.rawValue)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                }
                
                Section(header: Text("Язык")) {
                    Picker("Язык", selection: $viewModel.settings.selectedLanguage) {
                        ForEach(viewModel.availableLanguages, id: \.0) { code, name in
                            Text(name).tag(code)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                }
                
                Section(header: Text("Горячие клавиши")) {
                    Toggle("Включить горячую клавишу", isOn: $viewModel.settings.hotKeyEnabled)
                    Text("Комбинация: ⌘⇧Пробел")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                Section(header: Text("Автовставка")) {
                    Toggle("Включить автовставку текста", isOn: $viewModel.settings.autoInsertText)
                    Text("Требует разрешений системы")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                Section {
                    Button("Сбросить настройки") {
                        viewModel.resetToDefaults()
                    }
                    .foregroundColor(.red)
                }
            }
            .navigationTitle("Настройки")
            .padding()
        }
        .frame(minWidth: 450, minHeight: 500)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}