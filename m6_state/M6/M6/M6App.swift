import SwiftUI

@main
struct M6App: App {
    var body: some Scene {
        WindowGroup {
            PersonView(store: PersonStore())
        }
    }
}
