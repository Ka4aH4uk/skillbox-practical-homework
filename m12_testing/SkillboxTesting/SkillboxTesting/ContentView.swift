import SwiftUI

struct ContentView: View {
    @State var login: String = ""
    @State var password: String = ""
    @State var password2: String = ""
    @State var message: String = ""
    
    let loginService = LoginService()
    
    var body: some View {
        HStack {
            Image(systemName: "person")
            TextField("", text: $login, prompt: Text("Enter login"))
                .frame(width: 200)
                .textFieldStyle(.roundedBorder)
                .padding()
        }
        HStack {
            Image(systemName: "key")
            TextField("", text: $password, prompt: Text("Enter password"))
                .frame(width: 200)
                .textFieldStyle(.roundedBorder)
                .padding()
        }
        HStack {
            Image(systemName: "key.fill")
            TextField("", text: $password2, prompt: Text("Repeat password"))
                .frame(width: 200)
                .textFieldStyle(.roundedBorder)
                .padding()
        }
        
        if message.isEmpty {
            Text("").padding()
        } else {
            Text(message).padding()
        }
        Button("Register", action: register)
            .buttonStyle(.bordered)
    }
    
    func register() {
        let result = loginService.checkCredentials(
            login: login,
            password: password,
            password2: password2
        )
        
        switch result {
        case .invalidLogin:
            message = "Enter correct email"
        case .shortPassword:
            message = "Password should be more than 6 symbols"
        case .passworNotHaveDigits:
            message = "Password should have at least one digit"
        case .passwordNotUppercased:
            message = "Password should have at least one upper letter"
        case .passwordNotLowercased:
            message = "Password should have at least one lower letter"
        case .passwordHasIllegalCharacters:
            message = "Password contains illegal characters"
        case .passwordsMismatch:
            message = "Passwords are not identical"
        case .correct:
            message = "You are successfully registered!"
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
