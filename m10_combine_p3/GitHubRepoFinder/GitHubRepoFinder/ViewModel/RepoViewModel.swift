import Foundation
import Combine

final class RepoViewModel: ObservableObject {
    @Published private(set) var repoAndBranch: [RepoAndBranch] = []
    @Published private(set) var isLoading = false
    
    @Published var searchText: String = ""
    
    private var storage = Set<AnyCancellable>()
    
    init() {
        $searchText
            .debounce(for: .seconds(2), scheduler: RunLoop.main)
            .removeDuplicates()
            .map({ (string) -> String? in
                if string.count < 1 {
                    self.repoAndBranch = []
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
            repoAndBranch = []
            return
        }
        
        isLoading = true
        
        guard let company = searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            isLoading = false
            return
        }
        
        loadRepositories(company: company)
            .flatMap { repositories -> AnyPublisher<[RepoAndBranch], Never> in
                let branchPublishers = repositories.map { repository -> AnyPublisher<[Branch], Never> in
                    self.loadBranches(company: company, repoName: repository.name)
                        .map { branches -> [Branch] in
                            branches.map { Branch(name: $0.name) }
                        }
                        .eraseToAnyPublisher()
                }
                
                return Publishers.Zip(repositories.publisher, Publishers.MergeMany(branchPublishers))
                    .collect()
                    .map { zipResults -> [RepoAndBranch] in
                        zipResults.map { RepoAndBranch(repository: $0.0, branches: $0.1) }
                    }
                    .eraseToAnyPublisher()
            }
            .handleEvents(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Search error: \(error)")
                }
                DispatchQueue.main.async {
                    self?.isLoading = false
                }
            }, receiveCancel: { [weak self] in
                DispatchQueue.main.async {
                    self?.isLoading = false
                }
            })
            .receive(on: DispatchQueue.main)
            .sink { [weak self] repoAndBranch in
                DispatchQueue.main.async {
                    self?.repoAndBranch = repoAndBranch
                }
            }
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
    
    func loadBranches(company: String, repoName: String) -> AnyPublisher<[Branch], Never> {
        guard let url = URL(string: "https://api.github.com/repos/\(company)/\(repoName)/branches") else {
            return Just([])
                .eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [Branch].self, decoder: JSONDecoder())
            .catch { error -> Just<[Branch]> in
                print("Branch loading error: \(error)")
                return Just([])
            }
            .replaceError(with: [])
            .eraseToAnyPublisher()
    }
}
