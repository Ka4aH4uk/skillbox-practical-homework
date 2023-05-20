import SwiftUI

@main
struct GitHubRepoFinderApp: App {
    var body: some Scene {
        WindowGroup {
            GitHubRepoLauncScreenView()
                .preferredColorScheme(.dark)
        }
    }
}
