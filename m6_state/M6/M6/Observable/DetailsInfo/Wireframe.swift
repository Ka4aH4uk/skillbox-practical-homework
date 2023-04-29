import SwiftUI

final class DetailsWireframe {
    static func makeView() -> DetailsView {
        let service = DetailsService()
        let viewModel = ViewModel(service: service)
        let view = DetailsView(viewModel: viewModel)
        return view
    }
}
