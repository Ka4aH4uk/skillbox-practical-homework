import UIKit

final class NewTransitionViewController: UIViewController {
    let viewModel: NewTransitionViewModel
    
    init(viewModel: NewTransitionViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var modalButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Open", for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(openModalScreen), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        view.addSubview(modalButton)
        NSLayoutConstraint.activate([
            modalButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            modalButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            modalButton.widthAnchor.constraint(equalToConstant: 150),
            modalButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func openModalScreen() {
        viewModel.openModalScreen()
    }
}


