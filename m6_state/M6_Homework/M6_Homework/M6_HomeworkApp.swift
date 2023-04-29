import SwiftUI

@main
struct M6_HomeworkApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: ViewModel(service: UnstableNetworkService()))
        }
    }
}
