import UIKit

final class CustomTransition: NSObject {
    var isAnimated: Bool = true

    private weak var from: UIViewController?
    private var to: UIViewController?
    private var completion: (() -> Void)?

    init(isAnimated: Bool = true) {
        self.isAnimated = isAnimated
    }
}

extension CustomTransition: Transition {
    // MARK: - Transition
    
    func open(_ viewController: UIViewController, from: UIViewController, completion: (() -> Void)?) {
        self.from = from
        self.to = viewController
        self.completion = completion
        
        let containerView = UIView(frame: from.view.bounds)
        containerView.backgroundColor = .clear
        containerView.addSubview(viewController.view)
        from.view.addSubview(containerView)
        
        // Создаем UIImageView для анимации
        let imageView = UIImageView(image: UIImage(named: "loading"))
        imageView.contentMode = .bottom
        imageView.frame = from.view.bounds
        from.view.addSubview(imageView)

        let duration = isAnimated ? 1.5 : 0.0
        viewController.view.transform = CGAffineTransform(translationX: 0, y: containerView.bounds.height)

        UIView.animate(withDuration: duration, animations: {
            viewController.view.transform = .identity
        }, completion: { _ in
            imageView.removeFromSuperview()
            completion?()
        })
    }

    func close(_ viewController: UIViewController, completion: (() -> Void)?) {
        guard let from = from, let _ = to else { return }
        self.completion = completion
        
        // Создаем UIImageView для анимации
        let imageView = UIImageView(image: UIImage(named: "loading"))
        imageView.contentMode = .bottom
        imageView.frame = viewController.view.bounds
        viewController.view.addSubview(imageView)
        
        let duration = isAnimated ? 1.5 : 0.0
        UIView.animate(withDuration: duration, animations: {
            viewController.view.transform = CGAffineTransform(translationX: 0, y: from.view.bounds.height)
        }, completion: { _ in
            imageView.removeFromSuperview()
            viewController.view.removeFromSuperview()
            completion?()
        })
    }
}
