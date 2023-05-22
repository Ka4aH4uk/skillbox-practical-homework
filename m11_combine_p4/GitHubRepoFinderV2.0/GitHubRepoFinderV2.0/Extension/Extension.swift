import SwiftUI

extension GitHubRepoLauncScreenView {
    var gitImage: some View {
        Image("github")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: UIScreen.main.bounds.width / 2.5, height: UIScreen.main.bounds.width / 2.5)
    }
}

extension GitHubRepoSearchView {
    var gitImage2: some View {
        Image("github2")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: UIScreen.main.bounds.width / 2.5, height: UIScreen.main.bounds.width / 2.5)
    }
}
