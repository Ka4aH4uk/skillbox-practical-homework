import SwiftUI

struct ContentView: View {
    @State private var rectColor: Color = Color.green
    @State private var rectCornerRadius: CGFloat = 0
    @State private var rectWidth: CGFloat = 100
    
    var body: some View {
        VStack(spacing: 140){
            Rectangle()
                .fill(rectColor)
                .frame(width: rectWidth, height: 100, alignment: .center)
                .cornerRadius(rectCornerRadius)
            
            Button(action: {
                withAnimation {
                    rectWidth += 50
                    rectCornerRadius += 50
                }
            }) {
                Text("Анимация")
                    .foregroundColor(.white)
                    .bold()
            }
            .padding()
            .background(Color.blue)
            .cornerRadius(rectWidth)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
