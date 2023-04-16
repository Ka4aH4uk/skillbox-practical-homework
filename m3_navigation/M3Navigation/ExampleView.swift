import SwiftUI

struct ExampleView: View {
    @State var showingSheet = false
    
    init() {
        UINavigationBar.appearance().backgroundColor = .gray
        
        UINavigationBar.appearance().largeTitleTextAttributes = [
            .foregroundColor: UIColor.darkGray,
            .font : UIFont(name:"Papyrus", size: 40)!]
        
        UINavigationBar.appearance().titleTextAttributes = [
            .font : UIFont(name: "HelveticaNeue-Thin", size: 20)!]
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Hello, world!")
                .padding(8)

                NavigationLink {
                    ExampleLoginView(showingSheet: $showingSheet, text: "Login")
                } label: {
                    Text("Переход на Login")
                }
                
                Button("Модальный Login") {
                    showingSheet = true
                }
                .padding(8)
            }
            .navigationBarItems(
                leading:
                    Button(action: {}) {
                        Image(systemName: "minus.square.fill")
                            .font(.largeTitle)
                    }
                    .foregroundColor(.pink),
                trailing:
                    Button(action: {}) {
                        Image(systemName: "plus.square.fill")
                            .font(.largeTitle)
                    }
                    .foregroundColor(.yellow)
            )
            
            .navigationBarTitle(Text("Main"), displayMode: .large)
            .navigationBarHidden(true)
            .sheet(isPresented: $showingSheet) {
                ExampleLoginView(showingSheet: $showingSheet, text: "Login")
            }
        }
    }
}

struct ExampleLoginView: View {
    @Binding var showingSheet: Bool
    let text: String
    
    var body: some View {
        VStack {
            Text(text)
            
            Button("Закрыть") {
                showingSheet = false
            }
        }
    }
}

struct ExampleView_Previews: PreviewProvider {
    static var previews: some View {
        ExampleView()
    }
}
