import SwiftUI

struct TabBarView: View {
    var body: some View {
        TabView {
            ExampleView()
                .tabItem {
                    Label("Main", systemImage: "list.dash")
                }
            
            LoginView(text: "Login")
                .tabItem {
                    Label("Login", systemImage: "square.and.pencil")
                }
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}

