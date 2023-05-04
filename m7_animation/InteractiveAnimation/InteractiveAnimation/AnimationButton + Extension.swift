import SwiftUI
import CoreHaptics

//MARK: - Unlock Button
public struct DraggingComponent: View {
    @Binding var isLocked: Bool
    let isLoading: Bool
    let maxWidth: CGFloat

    @State private var width = CGFloat(50)
    private  let minWidth = CGFloat(50)

    public init(isLocked: Binding<Bool>, isLoading: Bool, maxWidth: CGFloat) {
        _isLocked = isLocked
        self.isLoading = isLoading
        self.maxWidth = maxWidth
    }

    public var body: some View {
        RoundedRectangle(cornerRadius: 16)
            .fill(Color.blueDark)
            .opacity(width / maxWidth)
            .frame(width: width, height: 55)
            .overlay(
                Button(action: { }) {
                    ZStack {
                        image(name: "lock", isShown: isLocked)
                        progressView(isShown: isLoading)
                        image(name: "lock.open", isShown: !isLocked && !isLoading)
                    }
                    .animation(.easeIn(duration: 0.35).delay(0.55), value: !isLocked && !isLoading)
                }
                .buttonStyle(BaseButtonStyle())
                .disabled(!isLocked || isLoading),
                alignment: .trailing
            )

            .simultaneousGesture(
                DragGesture()
                    .onChanged { value in
                        guard isLocked else { return }
                    if value.translation.width > 0 {
                        width = min(max(value.translation.width + minWidth, minWidth), maxWidth)
                    }
                    }
                    .onEnded { value in
                        guard isLocked else { return }
                        if width < maxWidth {
                            width = minWidth
                            UINotificationFeedbackGenerator().notificationOccurred(.warning)
                        } else {
                            UINotificationFeedbackGenerator().notificationOccurred(.success)
                            withAnimation(.spring().delay(0.5)) {
                                isLocked = false
                            }
                        }
                    }
            )
            .animation(.spring(response: 0.5, dampingFraction: 1, blendDuration: 0), value: width)
    }

    private func image(name: String, isShown: Bool) -> some View {
        Image(systemName: name)
            .font(.system(size: 20, weight: .regular, design: .rounded))
            .foregroundColor(Color.blueDark)
            .frame(width: 42, height: 42)
            .background(RoundedRectangle(cornerRadius: 14).fill(.white))
            .padding(4)
            .opacity(isShown ? 1 : 0)
            .scaleEffect(isShown ? 1 : 0.01)
    }

    private func progressView(isShown: Bool) -> some View {
        ProgressView()
            .progressViewStyle(.circular)
            .tint(.white)
            .opacity(isShown ? 1 : 0)
            .scaleEffect(isShown ? 1 : 0.01)
    }
}

public struct UnlockButton: View {
    @State private var isLocked = true
    @State private var isLoading = false
    
    public init() { }
    
    public var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                BackgroundComponent()
                DraggingComponent(isLocked: $isLocked, isLoading: isLoading, maxWidth: geometry.size.width)
            }
        }
        .frame(height: 50)
        .padding()
        .padding(.bottom, 20)
        .onChange(of: isLocked) { isLocked in
            guard !isLocked else { return }
            simulateRequest()
        }
    }
    
    private func simulateRequest() {
        isLoading = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            isLoading = false
        }
    }
}

public struct BaseButtonStyle: ButtonStyle {
    public init() { }

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .opacity(configuration.isPressed ? 0.9 : 1)
            .animation(.default, value: configuration.isPressed)
    }
}

//MARK: - First Background
struct BackgroundComponent: View {
    @State private var hueRotation = false

    var body: some View {
        Color.white
            .overlay(
                VStack {
                    DateTimeView()
                    Spacer()
                }
                .padding(.top, 100)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .fill(
                        LinearGradient(
                            colors: [Color.blueBright.opacity(0.6), Color.blueDark.opacity(0.6)],
                            startPoint: .bottom,
                            endPoint: .top
                        )
                    )
                    .hueRotation(.degrees(hueRotation ? 20 : -20))
            )
            .overlay(
                Text(">>> Slide to unlock <<<")
                    .font(.footnote)
                    .bold()
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(50),
                alignment: .bottom
            )
            .onAppear {
                withAnimation(.linear(duration: 3).repeatForever(autoreverses: true)) {
                    hueRotation.toggle()
                }
            }
    }
}

//MARK: - Date & Time View
struct DateTimeView: View {
    @State private var timeString: String = ""
    @State private var dateString: String = ""

    var body: some View {
        VStack {
            Text(timeString)
                .font(Font.custom("Avenir-Light", size: 60))
                .foregroundColor(.pinkBright)
            Text(dateString)
                .font(Font.custom("Avenir-Light", size: 30))
                .foregroundColor(.pinkBright)
        }
        .onAppear {
            updateTime()
        }
        .onReceive(Timer.publish(every: 1, on: .main, in: .common).autoconnect()) { _ in
            updateTime()
        }
    }

    private func updateTime() {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        timeString = formatter.string(from: Date())
        
        formatter.dateFormat = "EEEE"
        let dayOfWeek = formatter.string(from: Date())
        
        formatter.dateFormat = "dd MMMM"
        let monthAndDay = formatter.string(from: Date()).lowercased()
        
        dateString = "\(dayOfWeek.capitalized), \(monthAndDay)"
    }
}

// MARK: - Second Background
public struct SecondBackgroundComponent: View {
    @State private var hueRotation = false
    
    public init() { }
    
    public var body: some View {
        ZStack(alignment: .leading)  {
            Color.white
            RoundedRectangle(cornerRadius: 16)
                .fill(
                    LinearGradient(
                        colors: [Color.blueDark.opacity(0.6), Color.pinkBright.opacity(0.6)],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .hueRotation(.degrees(hueRotation ? 20 : -20))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.all)
        }
        .onAppear {
            withAnimation(.linear(duration: 3).repeatForever(autoreverses: true)) {
                hueRotation.toggle()
            }
        }
    }
}

// MARK: - Color
public extension Color {
    static let pinkBright = Color(red: 247/255, green: 37/255, blue: 133/255)
    static let blueBright = Color(red: 67/255, green: 97/255, blue: 238/255)
    static let blueDark = Color(red: 58/255, green: 12/255, blue: 163/255)
}
