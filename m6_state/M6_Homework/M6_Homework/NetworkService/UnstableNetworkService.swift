import Combine
import Foundation

enum ServiceError: Error {
    case noService
}

class UnstableNetworkService {
    private var cancellables: Set<AnyCancellable> = []
    
    func getData(
        success: @escaping ([Animal]) -> Void,
        failure: @escaping (Error) -> Void
    ) {
        Just(())
            .delay(for: .seconds(2), scheduler: DispatchQueue.main)
            .eraseToAnyPublisher()
            .tryMap { response -> [Animal] in
                let success = Bool.random()
                if success {
                    return DataAnimals().animals
                } else {
                    throw ServiceError.noService
                }
            }
            .eraseToAnyPublisher()
            .sink { completion in
                if case .failure = completion {
                    failure(ServiceError.noService)
                }
            } receiveValue: { data in
                success(data)
            }
            .store(in: &cancellables)
    }
}
