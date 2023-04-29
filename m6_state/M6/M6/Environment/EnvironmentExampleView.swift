import SwiftUI

class GameSettings: ObservableObject {
    @Published var score = 0
}

struct ScoreView: View {
    @EnvironmentObject var settings: GameSettings
    
    @Environment(\.editMode) var editMode
        
    var body: some View {
        Text("Счет: \(settings.score)")
    }
}

struct EnvironmentExampleView: View {
    @StateObject var settings = GameSettings()
    
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            VStack {
                Button("Увеличить счет") {
                    settings.score += 1
                    self.presentationMode.wrappedValue.dismiss()
                }
                Spacer(minLength: 16)
                NavigationLink(destination: ScoreView()) {
                    Text("Экран со счетом")
                }
            }
            .frame(height: 200)
        }
//        .environmentObject(settings)
    }
}
