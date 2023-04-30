import Foundation

final class ViewModel: ObservableObject {
    let service: UnstableNetworkService
    @Published var animals: [Animal] = []

    init(service: UnstableNetworkService) {
        self.service = service
        
        service.getData { result in
            print(result)
        } failure: { error in
            print(error)
        }
    }
}
        
