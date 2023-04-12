import Foundation

final class ModalScreenViewModel {
    typealias Routes = Dismissable & NewTransitionRoute & ModalScreenRoute
    private let router: Routes

    init(router: Routes) {
        self.router = router
    }

    func dismiss() {
        router.dismiss()
    }
}
