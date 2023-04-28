import SwiftUI

struct ConditionView: View {
    @State var tapCount: Int = 0
    
    var body: some View {
        if tapCount > 5 {
            ErrorView {
                tapCount = 0
            }
        } else {
            makeBody()
        }
    }
}

extension ConditionView {
    func makeBody() -> some View {
        VStack(alignment: .leading) {
            HStack(spacing: 16.0) {
                Text("Skill Box!")
                    .font(.largeTitle)
                    .foregroundColor(Color.mint)
            }
            Button(action: {
                tapCount += 1
            }) {
                Text("Количество нажатий: \(tapCount)")
                    .font(.title)
            }
        }
    }
}

struct ConditionView_Previews: PreviewProvider {
    static var previews: some View {
        ConditionView()
    }
}
