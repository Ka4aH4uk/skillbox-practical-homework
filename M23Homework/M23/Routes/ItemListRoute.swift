import UIKit

protocol ItemListRoute {
    func makeItemList() -> UIViewController
}

extension ItemListRoute where Self: Router {
    func makeItemList() -> UIViewController {
        let router = DefaultRouter(rootTransition: EmptyTransition())
        let viewModel = ItemListViewModel(router: router)
        let viewController = ItemListViewController(viewModel: viewModel)
        router.root = viewController

        let navigation = UINavigationController(rootViewController: viewController)
        navigation.tabBarItem = UITabBarItem(title: "List", image: nil, tag: 0)
        return navigation
    }

    func selectListTab() {
        root?.tabBarController?.selectedIndex = 0
    }
}

extension DefaultRouter: ItemListRoute {}
