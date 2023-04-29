import Combine

class ViewModel: ObservableObject{

    @Published var state: DetailsState
    private let service: DetailsService
    private var cancellables: [AnyCancellable] = []

    init(
        service: DetailsService
    ) {
        self.service = service
        self.state = DetailsState.makeState(policy: DetailsResponse.Seeds.empty)
    }

    func viewDidAppear() {
        load()
    }

    func didCloseAction() {

    }

    func load() {
        service.getDetails()
            .sink { response in
                self.state = DetailsState.makeState(policy: response)
            }
            .store(in: &cancellables)
    }

    func downloadPolicy(_ id: String) {
        print("downloadPolicy with id:" + "\(id)")
    }
}

