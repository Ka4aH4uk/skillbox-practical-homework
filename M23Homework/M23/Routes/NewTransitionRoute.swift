import UIKit

protocol NewTransitionRoute {
    func makeNewTransition() -> UIViewController
}

extension NewTransitionRoute where Self: Router {
    func makeNewTransition() -> UIViewController {
        let router = DefaultRouter(rootTransition: EmptyTransition())
        let viewModel = NewTransitionViewModel(router: router)
        let viewController = NewTransitionViewController(viewModel: viewModel)
        router.root = viewController
        
        viewController.tabBarItem = UITabBarItem(title: "New Transition", image: UIImage(systemName: "rectangle.stack.fill"), tag: 1)
        return viewController
    }
    
    func selectListTab() {
        root?.tabBarController?.selectedIndex = 0
    }
}
