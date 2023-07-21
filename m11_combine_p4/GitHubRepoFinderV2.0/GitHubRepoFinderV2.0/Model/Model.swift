import Foundation

struct Repository: Decodable {
    let name: String
}

struct ErrorItem: Identifiable {
    let id = UUID()
    let error: String
}
