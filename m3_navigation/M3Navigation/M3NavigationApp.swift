import SwiftUI

@main
struct M3NavigationApp: App {
    var body: some Scene {
        WindowGroup {
            TabBar(router: TabBarRouter())
        }
    }
}
