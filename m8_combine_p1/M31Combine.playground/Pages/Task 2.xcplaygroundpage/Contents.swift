import Foundation
import Combine

//let url = URL(string: "http://www.iosandroid.ru/")! // networkError
//let url = URL(string: "http://www.skillbox.ru/")! // 200
//let url = URL(string: "http://www.skillbox.ru/welcome")! // 404
let url = URL(string: "http://httpbin.org/status/500")! // invalidResponse

enum MyError: Error {
    case invalidResponse
    case networkError(error: Error)
}

let subscription = URLSession.shared.dataTaskPublisher(for: url)
    .tryMap { data, response -> Int in
        guard let httpResponse = response as? HTTPURLResponse else {
            throw MyError.invalidResponse
        }
        return httpResponse.statusCode
    }
    .mapError { error -> MyError in
        if let error = error as? MyError {
            return error
        }
        return MyError.networkError(error: error)
    }
    .sink(receiveCompletion: { completion in
        switch completion {
        case .finished:
            print("Success!")
        case .failure(error: let error):
            print("Error: \(error)")
        }
    }, receiveValue: { response in
        print("Response with status code: \(response).")
    })

