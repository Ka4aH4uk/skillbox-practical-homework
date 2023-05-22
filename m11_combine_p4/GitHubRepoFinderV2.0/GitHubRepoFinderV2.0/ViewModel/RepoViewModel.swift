import Foundation
import Combine

final class RepoViewModel: ObservableObject {
    @Published private(set) var repository: [Repository] = []
    @Published private(set) var isLoading = false
    
    @Published var searchText: String = ""
    
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
        
        loadRepositories(company: company)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Search error: \(error)")
                }
                self?.isLoading = false
            }, receiveValue: { [weak self] repositories in
                self?.repository = repositories
            })
            .store(in: &storage)
    }
    
    func loadRepositories(company: String) -> AnyPublisher<[Repository], Never> {
        guard let url = URL(string: "https://api.github.com/orgs/\(company)/repos") else {
            return Just([])
                .eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [Repository].self, decoder: JSONDecoder())
            .catch { error -> Just<[Repository]> in
                print("Repository loading error: \(error)")
                return Just([])
            }
            .replaceError(with: [])
            .eraseToAnyPublisher()
    }
}
