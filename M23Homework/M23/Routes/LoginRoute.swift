import UIKit

protocol LoginRoute {
    func openLogin()
}

extension LoginRoute where Self: Router {
    func openLogin(with transition: Transition) {
        let router = DefaultRouter(rootTransition: transition)
        let viewModel = LoginViewModel(router: router)
        let viewController = LoginViewController(viewModel: viewModel)
        let navigationController = UINavigationController(rootViewController: viewController)
        router.root = viewController

        route(to: navigationController, as: transition)
    }

    func openLogin() {
        openLogin(with: AnimatedTransition(animatedTransition: FadeAnimatedTransitioning()))
    }
}

extension DefaultRouter: LoginRoute {}
