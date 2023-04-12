import Foundation

final class NewTransitionViewModel {
    typealias Routes = NewTransitionRoute & ModalScreenRoute
    private var router: Routes

    init(router: Routes) {
        self.router = router
    }

    func openModalScreen() {
        router.openModalScreen()
    }
}
