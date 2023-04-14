import SwiftUI

struct ContentView: View {
    @State var alpha = 0.0
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, Sergey!")
                .font(.title)
                .fontWeight(.medium)
                .foregroundColor(Color.red)
                .padding(5)
            Text("My name is Konstantin!😉")
                .font(.title2)
                .foregroundColor(Color.black)
                .opacity(alpha)
                .onAppear {
                    let baseAnimation = Animation.easeInOut(duration: 3)
                    withAnimation(baseAnimation) {
                        alpha = 1.0
                    }
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
