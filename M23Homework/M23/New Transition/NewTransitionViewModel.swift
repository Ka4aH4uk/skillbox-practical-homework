import UIKit

final class NewTransitionViewModel {
    typealias Routes = Closable & NewTransitionRoute
    private let router: Routes

    init(router: Routes) {
        self.router = router
    }

    func dismiss() {
        router.close()
    }
    
    func openNextScreen() {
        router.openNextScreen()
    }
}
