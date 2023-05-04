import SwiftUI

struct LockScreenView: View {
    @State private var isLocked = true
    @State private var isLoading = false
    @State private var showSecondView = false

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            BackgroundComponent()
            VStack {
                if isLocked {
                    DraggingComponent(isLocked: $isLocked,
                                      isLoading: isLoading,
                                      maxWidth: UIScreen.main.bounds.width - 80)
                    .padding(.horizontal, 60)
                    .padding(.vertical, 30)
                } else {
                    SecondView(isLocked: $isLocked, showSecondView: $showSecondView)
                        .zIndex(1)
                        .transition(.scaleAndRotate)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LockScreenView()
    }
}
