import SwiftUI

struct SecondView: View {
    @Binding var isLocked: Bool
    @Binding var showSecondView: Bool

    var body: some View {
        ZStack {
            SecondBackgroundComponent()
            VStack {
                Spacer()
                Image(systemName: "lock.open.fill")
                    .font(.system(size: 100))
                    .foregroundColor(.white)
                    .padding()
                Text("Hello, Sergey!")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding()
                Spacer()
                Button(action: {
                    isLocked = true
                    showSecondView = false
                }, label: {
                    Image(systemName: "lock.fill")
                        .font(.system(size: 40))
                        .foregroundColor(.blueDark)
                        .padding()
                })
                .padding()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .edgesIgnoringSafeArea(.all)
    }
}

struct SecondView_Previews: PreviewProvider {
    static var previews: some View {
        SecondView(isLocked: .constant(true), showSecondView: .constant(true))
    }
}
