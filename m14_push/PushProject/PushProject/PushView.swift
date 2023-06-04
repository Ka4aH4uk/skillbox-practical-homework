import SwiftUI

struct PushView: View {
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [.cyan, .pink]),
                startPoint: .leading,
                endPoint: .bottomTrailing
            )
                .ignoresSafeArea()
            VStack {
                Image("push")
                    .resizable()
                    .scaledToFit()
                    .padding()
                Button {
                    print("")
                } label: {
                    Text("Отправить push-уведомление")
                        .frame(width: 150)
                        .foregroundColor(.white)
                        .font(.headline)
                        .padding()
                        .background(
                            RoundedRectangle(
                                cornerRadius: 20,
                                style: .continuous
                            )
                            .fill(.cyan)
                        )
                        .overlay {
                            RoundedRectangle(
                                cornerRadius: 20,
                                style: .continuous
                            )
                            .stroke(.pink, lineWidth: 2)
                        }
                }
                .padding()
                
                Button {
                    print("")
                } label: {
                    Text("Отменить все уведомления")
                        .frame(width: 150)
                        .foregroundColor(.white)
                        .font(.headline)
                        .padding()
                        .background(
                            RoundedRectangle(
                                cornerRadius: 20,
                                style: .continuous
                            )
                            .fill(.red)
                        )
                        .overlay {
                            RoundedRectangle(
                                cornerRadius: 20,
                                style: .continuous
                            )
                            .stroke(.pink, lineWidth: 2)
                        }
                }
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PushView()
    }
}
