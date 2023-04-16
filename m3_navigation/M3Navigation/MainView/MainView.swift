import SwiftUI

struct MainView<MainRouter: Router>: View where MainRouter.Route == MainRoute {
    let router: MainRouter
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Hello, Sergey!")
                    .padding()
                    .navigationTitle("Main")
                
                router.viewFor(route: .loginView(data: "Login")) {
                    Text("Переход на Login")
                }
            }
        }
    }
}

struct LoginView: View {
    let text: String
    
    var body: some View {
        Text(text)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(router: MainRouter())
    }
}
