import SwiftUI

struct MainView: View {
    @State private var tabSelection = 0
    @State private var isLoginModalPresented = false
    @State private var showLogin = false
    @State private var loginData: String = ""

    var body: some View {
        TabView(selection: $tabSelection) {
            NavigationView {
                VStack {
                    Text("Hello, Sergey!")
                        .padding()
                        .navigationTitle("Main")
                    NavigationLink(destination: LoginView(text: $loginData), isActive: $showLogin) {
                        Text("Переход на Login")
                    }
                }
                .navigationBarItems(trailing: Button(action: {
                    isLoginModalPresented = true
                }) {
                    Image(systemName: "person.circle")
                        .resizable()
                        .frame(width: 35, height: 35)
                        .foregroundColor(.green)
                        .padding(10)
                })
                .sheet(isPresented: $isLoginModalPresented, onDismiss: {
                    // Действие, выполняемое при закрытии модального окна
                }, content: {
                    LoginView(text: $loginData)
                })
//                .tag(0)
            }
//            .tabItem {
//                Label("Main", systemImage: "house.fill")
//            }
//
//            NavigationView {
//                Text("Catalog")
//                    .navigationTitle("Catalog")
//            }
//            .tag(1)
//            .tabItem {
//                Label("Catalog", systemImage: "book.fill")
//            }
//
//            NavigationView {
//                Text("Login")
//                    .navigationTitle("Login")
//            }
//            .tag(2)
//            .tabItem {
//                Label("Login", systemImage: "person.fill")
//            }
        }
    }
}


//struct MainView: View {
//    @State private var tabSelection = 0
//    @State private var isLoginModalPresented = false
//    @State private var loginData: String = ""
//
//    var body: some View {
//        NavigationView {
//            VStack {
//                Text("Hello, Sergey!")
//                    .padding()
//                    .navigationTitle("Main")
//                Button(action: {
//                    isLoginModalPresented.toggle()
//                }, label: {
//                    Text("Переход на Login")
//                })
//                .navigationBarItems(trailing: Button(action: {
//                    isLoginModalPresented = true
//                }) {
//                    Image(systemName: "person.circle")
//                        .resizable()
//                        .frame(width: 35, height: 35)
//                        .foregroundColor(.green)
//                        .padding(10)
//                })
//                .sheet(isPresented: $isLoginModalPresented, onDismiss: {
//                    // Действие, выполняемое при закрытии модального окна
//                }, content: {
//                    LoginView(text: $loginData)
//                })
//                .tabItem {
//                    switch MainRoute.loginView(data: loginData) {
//                    case .loginView(let data):
//                        Text(data)
//                    }
//                }
//            }
//        }
//    }
//}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

//struct MainView: View {
//    @ObservedObject var router: MainRouter
//    @State var showLogin = false
//
//    var body: some View {
//        NavigationView {
//            VStack {
//                Text("Hello, Sergey!")
//                    .padding()
//                    .navigationTitle("Main")
//                router.viewFor(route: .loginView) {
//                    Text("Переход на Login").eraseToAnyView() // Исправление: преобразование Text в AnyView
//                }
//            }
//            .navigationBarItems(trailing: Button(action: {
//                showLogin = true
//            }) {
//                Image(systemName: "person.circle")
//                    .resizable()
//                    .frame(width: 35, height: 35)
//                    .foregroundColor(.green)
//                    .padding(10)
//            })
//            .sheet(item: $router.route) { route in
//                if route == .loginView {
//                    LoginView(text: "Login Modal")
//                }
//            }
//            .id(router.route) // явное указание типа идентификатора
//        }
//    }
//}




