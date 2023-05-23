import Foundation
import Combine

enum RepoError: Error {
    case badURL
    case decodingError
    case networkError(String)
}

final class RepoViewModel: ObservableObject {
    @Published private(set) var repository: [Repository] = []
    @Published private(set) var isLoading = false
    @Published var searchText: String = ""
    @Published var errorItem: ErrorItem? = nil
    
    private var storage = Set<AnyCancellable>()
    
    init() {
        $searchText
            .debounce(for: .seconds(2), scheduler: RunLoop.main)
            .removeDuplicates()
            .map({ (string) -> String? in
                if string.count < 1 {
                    self.repository = []
                    return nil
                }
                
                return string
            })
            .sink { [weak self] _ in
                self?.searchRepositories()
            }
            .store(in: &storage)
    }
    
    func searchRepositories() {
        guard !searchText.isEmpty else {
            repository = []
            return
        }
        
        isLoading = true
        
        guard let company = searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            isLoading = false
            return
        }
        
        loadAllRepositories(company: company, perPage: 100) // Мин. значение per_page - 30, макс - 100
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self?.errorItem = ErrorItem(error: error.localizedDescription)
                }
                self?.isLoading = false
            }, receiveValue: { [weak self] repositories in
                self?.repository = repositories
            })
            .store(in: &storage)
    }
    
    func loadAllRepositories(company: String, page: Int = 1, perPage: Int) -> AnyPublisher<[Repository], Error> {
        return loadRepositories(company: company, page: page, perPage: perPage)
            .flatMap { [weak self] repositories -> AnyPublisher<[Repository], Error> in
                guard let self = self else { return Empty().eraseToAnyPublisher() }
                
                if repositories.count == perPage {
                    let nextPage = page + 1
                    
                    return self.loadAllRepositories(company: company, page: nextPage, perPage: perPage)
                        .map { repositories + $0 }
                        .eraseToAnyPublisher()
                } else {
                    return Just(repositories)
                        .setFailureType(to: Error.self)
                        .eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }
    
    func loadRepositories(company: String, page: Int, perPage: Int) -> AnyPublisher<[Repository], Error> {
        guard let url = URL(string: "https://api.github.com/orgs/\(company)/repos?page=\(page)&per_page=\(perPage)") else {
            return Fail(error: RepoError.badURL).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.setValue("Bearer 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", forHTTPHeaderField: "Authorization")
        
        print("Request URL: \(url)")
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw RepoError.networkError("Invalid response")
                }
                
                let statusCode = httpResponse.statusCode
                
                switch statusCode {
                case 200:
                    return data
                case 301:
                    throw RepoError.networkError("Moved permanently (Status code: \(statusCode))")
                case 403:
                    throw RepoError.networkError("Forbidden (Status code: \(statusCode))")
                case 422:
                    throw RepoError.networkError("Validation failed, or the endpoint has been spammed. (Status code: \(statusCode))")
                default:
                    throw RepoError.networkError("Unknown error (Status code: \(statusCode))")
                }
            }
            .decode(type: [Repository].self, decoder: JSONDecoder())
            .mapError { error in
                return RepoError.networkError(error.localizedDescription)
            }
            .eraseToAnyPublisher()
    }
}
