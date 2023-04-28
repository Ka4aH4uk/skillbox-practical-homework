import SwiftUI

struct GeometryReaderExample: View {
    @State private var childPos: CGFloat = 0
    
    var body: some View {
        VStack{
            HStack{
                Text("Offset: \(childPos, specifier: "%.0f")")
            Spacer()
            }
            .hidden(childPos > 120)
            .padding()
            
            ScrollView{
                GeometryReader{ geo in
                    Text("Элемент для отслеживания")
                    .preference(key: SizePreferenceKey.self, value: geo.frame(in: .global).minY)
                }.onPreferenceChange(SizePreferenceKey.self) { preferences in
                    self.childPos = preferences
                }
            }
            .padding()
        }
    }
}

struct SizePreferenceKey: PreferenceKey {
        typealias Value = CGFloat
        static var defaultValue: Value = 0

        static func reduce(value: inout Value, nextValue: () -> Value) {
            value = nextValue()
        }
}

struct GeometryReaderExample_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReaderExample()
    }
}

extension View {
    func hidden(_ shouldHide: Bool) -> some View {
        opacity(shouldHide ? 0 : 1)
    }
}
