import SwiftUI

struct MainView: View {
    @EnvironmentObject var router: TabBarRouter
    @State private var showLoginModal = false

    var body: some View {
        NavigationView {
            ZStack {
                Image("welcomeImage")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                VStack {
                    Text("Hello, Sergey!")
                        .foregroundColor(.black)
                        .font(.largeTitle)
                    Button {
                        router.tabSelection = .login
                    } label: {
                        Text("Перейти на вкладку Login")
                            .padding()
                            .frame(maxWidth: 250)
                            .background(.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                .navigationTitle("Main")
                .navigationBarItems(trailing: Button(action: {
                    showLoginModal = true
                }) {
                    Image(systemName: "person.circle")
                        .resizable()
                        .frame(width: 35, height: 35)
                        .foregroundColor(.green)
                        .padding(10)
                })
                .sheet(isPresented: $showLoginModal, content: {
                    LoginView(router: _router)
                })
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(TabBarRouter())
    }
}
