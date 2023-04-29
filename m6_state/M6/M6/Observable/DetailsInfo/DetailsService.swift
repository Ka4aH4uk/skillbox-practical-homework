import Combine

struct DetailsService {
    func getDetails() -> AnyPublisher<DetailsResponse, Never> {
        CurrentValueSubject<DetailsResponse, Never>(
            DetailsResponse.Seeds.defaultModel
        ).eraseToAnyPublisher()
    }
}
