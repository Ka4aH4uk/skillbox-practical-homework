import SwiftUI

struct LoginView: View {
    @Binding var text: String
    
    var body: some View {
        NavigationView {
            VStack {
                Text("")
                    .navigationTitle("Login")
                TextField("Enter login", text: $text)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                Button(action: {
                    // Действие при нажатии на кнопку
                }, label: {
                    Text("Войти в ЛК")
                })
                .padding()
            }
        }
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(text: .constant(""))
    }
}
