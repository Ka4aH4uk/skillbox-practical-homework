import Foundation

final class ItemListViewModel {
    typealias Routes = LoginRoute & ItemRoute
    private let router: Routes

    init(router: Routes) {
        self.router = router
    }

    func openItem() {
        router.openItem()
    }

    func openLogin() {
        router.openLogin()
    }
}
