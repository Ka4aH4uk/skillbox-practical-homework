import SwiftUI

struct ExampleZStack: View {
    var body: some View {
        ScrollView {

            Image(systemName: "globe.europe.africa")
                .font(.system(size: 300))
                .background {
                    Rectangle().foregroundColor(.mint)
                }
            
            Text("Africa")
                .font(.system(size: 25))
                .foregroundColor(.orange)
        }
    }
}


struct ExampleZStack_Previews: PreviewProvider {
    static var previews: some View {
        ExampleZStack()
    }
}
