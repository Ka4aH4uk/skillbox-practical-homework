import Foundation

struct Repository: Decodable {
    let name: String
    let language: String?
}

struct Branch: Decodable {
    let name: String
}

struct RepoAndBranch {
    let repository: Repository
    let branches: [Branch]
}
