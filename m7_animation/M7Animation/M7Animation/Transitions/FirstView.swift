import SwiftUI

struct MoveToModifier: ViewModifier & Animatable {
    
    var yOffset: CGFloat = UIScreen.main.bounds.height
    var xOffset: CGFloat = -UIScreen.main.bounds.width/2

    init(active: Bool) {
        self.progress = active ? 1 : 0
    }
    
    var progress: CGFloat
    
    var animatableData: CGFloat {
        get { progress }
        set { progress = newValue }
    }
    
    func body(content: Content) -> some View {
        content.offset(x: xOffset * progress, y: yOffset * progress)
    }
}

struct FirstView: View {
    
    @State var showView = false

    var body: some View {
        let moveTo = AnyTransition.modifier(
            active: MoveToModifier(active: true),
            identity: MoveToModifier(active: false)
        )
        
        ZStack {
            Color.green.ignoresSafeArea()
            
            Button {
                withAnimation{
                    showView.toggle()
                }
            } label: {
                Text("Present Screen")
                    .font(.title2)
                    .padding()
                    .padding(.horizontal)
            }
            .buttonStyle(.borderedProminent)
            
            if showView {
                SecondView(showView: $showView)
                    .zIndex(1)
                    .transition(moveTo)
            }
        }
    }
}

struct FirstView_Previews: PreviewProvider {
    static var previews: some View {
        FirstView()
    }
}
