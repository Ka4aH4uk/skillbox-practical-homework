import SwiftUI

struct ExampleStackView: View {
    @State var tapCount: Int = 0
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 16.0) {
                Text("Skill Box")
                    .font(.largeTitle)
                    .foregroundColor(Color.mint)
                Image(systemName: "note")
            }
            Button(action: {
                tapCount += 1
            }) {
                Text("Tap count \(tapCount)")
                    .font(.title)
            }
            Rectangle()
                .foregroundColor(.orange)
            Rectangle()
                .foregroundColor(.blue)
                .layoutPriority(100)
        }
    }
}

struct ExampleStackView_Previews: PreviewProvider {
    static var previews: some View {
        ExampleStackView()
    }
}
