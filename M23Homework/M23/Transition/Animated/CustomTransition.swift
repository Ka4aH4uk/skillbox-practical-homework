import UIKit

final class CustomTransition: NSObject {
    let customTransitionAnimation: CustomTransitionAnimation
    var isAnimated: Bool = true

    init(customTransitionAnimation: CustomTransitionAnimation, isAnimated: Bool = true) {
        self.customTransitionAnimation = customTransitionAnimation
        self.isAnimated = isAnimated
    }
}

extension CustomTransition: Transition {
    // MARK: - Transition
    func open(_ viewController: UIViewController, from: UIViewController, completion: (() -> Void)?) {
        viewController.transitioningDelegate = self
        viewController.modalPresentationStyle = .custom
        from.present(viewController, animated: isAnimated, completion: completion)
    }

    func close(_ viewController: UIViewController, completion: (() -> Void)?) {
        viewController.dismiss(animated: isAnimated, completion: completion)
    }
}

extension CustomTransition: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController,
                             presenting: UIViewController,
                             source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        customTransitionAnimation.isPresenting = true
        return customTransitionAnimation
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        customTransitionAnimation.isPresenting = false
        return customTransitionAnimation
    }
}
