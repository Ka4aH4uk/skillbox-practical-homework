import UIKit

final class CustomTransitionAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    var isPresenting: Bool = true
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 2.0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if isPresenting {
            present(using: transitionContext)
        } else {
            dismiss(using: transitionContext)
        }
    }
    
    private func present(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toViewController = transitionContext.view(forKey: .to) else { return }
        
        let containerView = transitionContext.containerView
        
        let imageView = UIImageView(image: UIImage(named: "loading"))
        imageView.center = CGPoint(x: containerView.bounds.midX, y: 250)
        containerView.addSubview(imageView)
        
        toViewController.alpha = 0.0
        containerView.addSubview(toViewController)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            imageView.alpha = 0.0
            toViewController.alpha = 1.0
        }, completion: { _ in
            imageView.removeFromSuperview()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
    
    private func dismiss(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromViewController = transitionContext.viewController(forKey: .from) else { return }
        
        let containerView = transitionContext.containerView
        
        let imageView = UIImageView(image: UIImage(named: "loading"))
        imageView.center = CGPoint(x: containerView.bounds.midX, y: 250)
        containerView.addSubview(imageView)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            imageView.alpha = 0.0
            fromViewController.view.alpha = 0.0
        }, completion: { _ in
            imageView.removeFromSuperview()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}
