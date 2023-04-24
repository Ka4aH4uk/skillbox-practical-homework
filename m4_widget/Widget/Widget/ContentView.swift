import SwiftUI

enum Key {
    static var text = "TEXT_KEY"
    static var colorText = "COLORTEXT_KEY"
    static var backgroundColor = "BACKGROUNDCOLOR_KEY"
    static var date = "DATE_KEY"
}

struct ContentView: View {
    @State private var text: String = ""
    @State private var colorText: Color = .black
    @State private var backgroundColor: Color = .white
    @State private var date: Date = Date()
    private var userDefaults = UserDefaults.standard
    
    var body: some View {
        NavigationView {
            List {
                Group {
                    TextField("Текст", text: $text)
                        .onChange(of: text, perform: { _ in
                            saveUserData()
                        })
                    ColorPicker("Цвет текста", selection: $colorText)
                        .onChange(of: colorText, perform: { _ in
                            saveUserData()
                        })
                    ColorPicker("Цвет фона", selection: $backgroundColor)
                        .onChange(of: backgroundColor, perform: { _ in
                            saveUserData()
                        })
                    DatePicker("Дата", selection: $date, displayedComponents: .date)
                        .onChange(of: date, perform: { _ in
                            saveUserData()
                        })
                }
            }
            .navigationTitle("Настройки")
        }
        .onAppear(perform: loadUserData)
    }
    
    // Сохраняем данные
    private func saveUserData() {
        userDefaults.set(text, forKey: Key.text)
        userDefaults.set(colorToString(color: colorText), forKey: Key.colorText)
        userDefaults.set(colorToString(color: backgroundColor), forKey: Key.backgroundColor)
        userDefaults.set(date, forKey: Key.date)
    }
    
    // Загружаем данные
    private func loadUserData() {
        text = userDefaults.string(forKey: Key.text) ?? ""
        if let colorTextString = userDefaults.string(forKey: Key.colorText) {
            colorText = stringToColor(colorString: colorTextString) ?? .black
        }
        if let backgroundColorString = userDefaults.string(forKey: Key.backgroundColor) {
            backgroundColor = stringToColor(colorString: backgroundColorString) ?? .white
        }
        date = userDefaults.object(forKey: Key.date) as? Date ?? Date()
    }
    
    // Преобразования цвета в строку и обратно
    func colorToString(color: Color) -> String {
        let rgbColor = UIColor(color)
        let data = try? NSKeyedArchiver.archivedData(withRootObject: rgbColor, requiringSecureCoding: false)
        return data?.base64EncodedString() ?? ""
    }

    func stringToColor(colorString: String) -> Color? {
        if let data = Data(base64Encoded: colorString),
           let rgbColor = try? NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: data) {
            return Color(rgbColor)
        }
        return nil
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
