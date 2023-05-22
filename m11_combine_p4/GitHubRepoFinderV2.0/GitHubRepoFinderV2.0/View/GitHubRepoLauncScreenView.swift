import SwiftUI

struct GitHubRepoLauncScreenView: View {
    @State private var showSearchView = false

    var body: some View {
        NavigationView {
            ZStack {
                Color.black
                    .ignoresSafeArea()
                VStack {
                    Spacer()
                    gitImage
                    Spacer()
                    NavigationLink(
                        destination: GitHubRepoSearchView(showSearchView: self.$showSearchView),
                        label: {
                            HStack {
                                Image(systemName: "person.circle")
                                Text("Вход")
                            }
                            .font(.custom("Avenir", size: 20))
                            .foregroundColor(.white)
                            .fontWeight(.regular)
                        }
                    )
                    .padding(.vertical, 20)
                }
            }
            .navigationBarHidden(true)
        }
    }
}

struct GitHubRepoLauncScreenView_Previews: PreviewProvider {
    static var previews: some View {
        GitHubRepoLauncScreenView()
    }
}
