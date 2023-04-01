//
//  NetworkService.swift
//  MVP
//
//  Created by Ka4aH on 22.03.2023.
//

import Foundation

protocol NetworkServiceProtocol {
    func getTracks(urlString: String, completion: @escaping (Result<Tracks?, Error>) -> Void)
}

final class NetworkService: NetworkServiceProtocol {
    func getTracks(urlString: String, completion: @escaping (Result<Tracks?, Error>) -> Void) {
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                do {
                    let result = try JSONDecoder().decode(Tracks.self, from: data!)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                    print(String(describing: error))
                }
            }
        }
        task.resume()
    }
}
