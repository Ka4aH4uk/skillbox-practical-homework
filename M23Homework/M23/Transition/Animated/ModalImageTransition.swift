import UIKit

final class CustomModalTransition: NSObject, UIViewControllerAnimatedTransitioning {
    private let duration: TimeInterval
    
    init(duration: TimeInterval) {
        self.duration = duration
        super.init()
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let _ = transitionContext.viewController(forKey: .from),
              let _ = transitionContext.viewController(forKey: .to),
              let toView = transitionContext.view(forKey: .to) else {
            return
        }
        
        let containerView = transitionContext.containerView
        containerView.addSubview(toView)
        toView.frame = containerView.bounds
        toView.alpha = 0
        
        UIView.animate(withDuration: duration, animations: {
            toView.alpha = 1
        }) { _ in
            let transitionCompleted = !transitionContext.transitionWasCancelled
            transitionContext.completeTransition(transitionCompleted)
        }
    }
}




