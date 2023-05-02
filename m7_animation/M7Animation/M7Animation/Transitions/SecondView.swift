import SwiftUI

struct SecondView: View {
    
    @Binding var showView: Bool
    
    var body: some View {
        
        ZStack {
            Color.orange .ignoresSafeArea()
            
            VStack {
                Button {
                    withAnimation {
                        showView.toggle()
                    }
                } label: {
                    Image(systemName: "x.circle")
                        .foregroundColor(.black)
                        .font(.largeTitle)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .trailing)
                Spacer()
            }
            
            Text("This is the second one")
                .font(.title2.weight(.heavy))
        }
    }
}


struct SecondView_Previews: PreviewProvider {
    static var previews: some View {
        SecondView(showView: Binding.constant(true))
    }
}
