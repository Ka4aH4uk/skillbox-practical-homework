import UIKit

final class NewTransitionViewController: UIViewController, UIViewControllerTransitioningDelegate  {
    private let viewModel: NewTransitionViewModel
    private let router: ItemRoute
    
    init(viewModel: NewTransitionViewModel, router: ItemRoute) {
        self.viewModel = viewModel
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var openModalButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitle("Open Modal", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(onOpenModalButton), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "New Transition"
        view.addSubview(openModalButton)
        openModalButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            openModalButton.widthAnchor.constraint(equalToConstant: 200),
            openModalButton.heightAnchor.constraint(equalToConstant: 50),
            openModalButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            openModalButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc
    private func onButton() {
        router.openItem()
    }

    @objc private func onOpenModalButton() {
        let nextViewController = UIViewController()
        nextViewController.view.backgroundColor = .systemBlue
        nextViewController.modalPresentationStyle = .custom
        nextViewController.transitioningDelegate = self
        present(nextViewController, animated: true, completion: nil)
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CustomModalTransition(duration: 0.5)
    }
}




