import Foundation

final class ViewModel: ObservableObject {
    let service: UnstableNetworkService
    
    init(service: UnstableNetworkService) {
        self.service = service
        
        service.getData { result in
            print(result)
        } failure: { error in
            print(error)
        }
    }
}
