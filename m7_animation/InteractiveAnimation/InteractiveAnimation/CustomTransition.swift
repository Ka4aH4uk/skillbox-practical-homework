import SwiftUI

struct ScaleAndRotateTransition: ViewModifier {
    var progress: Double
    
    private let angle: Double = 30
    private let scale: CGFloat = 0.5
    private let animationStart: Double = 0.4
    
    func body(content: Content) -> some View {
        content
            .scaleEffect(
                progress < animationStart ?
                    CGFloat(progress / animationStart) :
                    CGFloat(1 + (progress - animationStart) / (1 - animationStart)) * scale,
                anchor: .bottom
            )
            .rotationEffect(
                .degrees(
                    progress < animationStart ?
                        angle - Double(progress / animationStart) * angle :
                        -angle + Double((progress - animationStart) / (1 - animationStart)) * angle
                ),
                anchor: .bottom
            )
            .animation(.spring(response: 1.2, dampingFraction: 0.7, blendDuration: 0.7), value: progress)
    }
}

public extension AnyTransition {
    static var scaleAndRotate: AnyTransition {
        AnyTransition.modifier(
            active: ScaleAndRotateTransition(progress: 0),
            identity: ScaleAndRotateTransition(progress: 1)
        )
    }
}
