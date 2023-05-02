import SwiftUI

struct InteractiveView: View {
    @State private var offset = CGSize.zero

    var body: some View {
        VStack {
            Circle()
                .fill(.red)
                .frame(width: 64, height: 64)
                .offset(offset)
            
            ScrollView {
                VStack {
                    Text("Target")
                        .background(
                            GeometryReader { geo -> Color in
                                offset = CGSize(
                                    width: geo.frame(in: .global).minY,
                                    height: 0
                                )
                                
                                return Color.clear
                            }
                        )
                    ForEach(0..<10) {_ in
                        Rectangle()
                            .frame(width: 200, height: 200, alignment: .center)
                            .foregroundColor(Color.blue)
                    }
                }
            }
        }
    }
}

struct InteractiveView_Previews: PreviewProvider {
    static var previews: some View {
        InteractiveView()
    }
}
