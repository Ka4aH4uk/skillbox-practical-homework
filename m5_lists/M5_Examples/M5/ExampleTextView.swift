import SwiftUI

struct ExampleTextView: View {
    var body: some View {
        ScrollView{
            Text("Hello, world!")
                .padding(.leading, 50.0)
        }
    }
}

struct ExampleTextView_Previews: PreviewProvider {
    static var previews: some View {
        ExampleTextView()
    }
}
