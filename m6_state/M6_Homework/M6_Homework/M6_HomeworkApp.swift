import SwiftUI

@main
struct M6_HomeworkApp: App {
    var body: some Scene {
        WindowGroup {
            AnimalView()
                .environmentObject(ViewModel(service: UnstableNetworkService()))
        }
    }
}
