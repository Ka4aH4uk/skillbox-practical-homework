import SwiftUI
import WidgetKit

struct ContentView: View {
    @AppStorage("COLORTEXT_KEY", store: UserDefaults(suiteName: "group.skillbox.k4"))
    var colorTextData: Data = Data()
    @AppStorage("BACKGROUNDCOLOR_KEY", store: UserDefaults(suiteName: "group.skillbox.k4"))
    var backgroundColorData: Data = Data()
    
    @State private var text: String = ""
    @State private var colorText: Color = .black
    @State private var backgroundColor: Color = .white
    @State private var date: Date = Date()
    
    var body: some View {
        NavigationView {
            List {
                TextField("Введите текст", text: $text)
                    .onChange(of: text, perform: { _ in
                        UserDefaults(suiteName: "group.skillbox.k4")?.set(text, forKey: "TEXT_KEY")
                        WidgetCenter.shared.reloadAllTimelines()
                    })
                ColorPicker("Цвет текста", selection: $colorText, supportsOpacity: false)
                    .onChange(of: colorText, perform: { value in
                        saveColorText(color: value)
                    })
                ColorPicker("Цвет фона", selection: $backgroundColor)
                    .onChange(of: backgroundColor, perform: { value in
                        saveBackgroundColor(color: value)
                    })
                DatePicker("Дата", selection: $date, displayedComponents: .date)
                    .onChange(of: date, perform: { _ in
                        UserDefaults(suiteName: "group.skillbox.k4")?.set(date, forKey: "DATE_KEY")
                        WidgetCenter.shared.reloadAllTimelines()
                    })
            }
            .navigationTitle("Настройки")
        }
        .onAppear(perform: loadUserData)
    }
    
    //MARK: Private Methods
    private func saveColorText(color: Color) {
        let uiColor = UIColor(color)
        do {
            colorTextData = try NSKeyedArchiver.archivedData(withRootObject: uiColor, requiringSecureCoding: false)
            WidgetCenter.shared.reloadAllTimelines()
        } catch let error {
            print("error colorTextData: \(error.localizedDescription)")
        }
    }
    
    private func saveBackgroundColor(color: Color) {
        let uiColor = UIColor(color)
        do {
            backgroundColorData = try NSKeyedArchiver.archivedData(withRootObject: uiColor, requiringSecureCoding: false)
            WidgetCenter.shared.reloadAllTimelines()
        } catch let error {
            print("error backgroundColorData: \(error.localizedDescription)")
        }
    }
    
    private func loadUserData() {
        print("Loading user defaults...")
        text = UserDefaults(suiteName: "group.skillbox.k4")?.string(forKey: "TEXT_KEY") ?? ""
        if let uiColor = try? NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: colorTextData) {
            colorText = Color(uiColor)
        }
        if let uiColor = try? NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: backgroundColorData) {
            backgroundColor = Color(uiColor)
        }
        date = UserDefaults(suiteName: "group.skillbox.k4")?.object(forKey: "DATE_KEY") as? Date ?? Date()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
