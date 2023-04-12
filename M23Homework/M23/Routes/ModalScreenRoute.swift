import UIKit

protocol ModalScreenRoute {
    func openModalScreen()
}

extension ModalScreenRoute where Self: Router {
    func openModalScreen(with transition: Transition) {
        let router = DefaultRouter(rootTransition: transition)
        let viewModel = ModalScreenViewModel(router: router)
        let viewController = ModalScreenViewController(viewModel: viewModel)
        router.root = viewController

        route(to: viewController, as: transition)
    }
    
    func openModalScreen() {
        openModalScreen(with: CustomTransition(customTransitionAnimation: CustomTransitionAnimation()))
    }
}

extension DefaultRouter: ModalScreenRoute {}
