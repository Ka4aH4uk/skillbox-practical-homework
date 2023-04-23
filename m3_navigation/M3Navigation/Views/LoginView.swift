import SwiftUI

struct LoginView: View {
    @EnvironmentObject var router: TabBarRouter
    @State private var loginData: String = ""
    @State private var passData: String = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("loginImage")
                    .aspectRatio(contentMode: .fill)
                VStack {
                    Spacer()
                    TextField("Введите логин", text: $loginData)
                        .frame(maxWidth: 360)
                        .textFieldStyle(.roundedBorder)
                        .foregroundColor(.blue)
                        .accentColor(.green)
                    TextField("Введите пароль", text: $passData)
                        .frame(maxWidth: 360)
                        .textFieldStyle(.roundedBorder)
                        .foregroundColor(.blue)
                        .accentColor(.green)
                        .padding(10)
                    Button(action: {
//                        router.tabSelection = .main
                    }) {
                        Text("Войти")
                            .padding()
                            .frame(maxWidth: 250)
                            .background(.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding(.bottom, 150)
                    }
                }
                .navigationBarTitle("Login")
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(TabBarRouter())
    }
}
