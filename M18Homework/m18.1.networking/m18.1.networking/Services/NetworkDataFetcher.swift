//
//  NetworkDataFetcher.swift
//  m18.1.networking
//
//  Created by Ka4aH on 20.02.2023.
//

import Foundation
import UIKit

class NetworkDataFetcher {
    
    let networkServices = NetworkService()
    
    func fetchFilms(urlString: String, response: @escaping (SearchResponse?) -> Void) {
        networkServices.request(urlString: urlString) { (result) in
            switch result {
            case .success(let data):
                do {
                    let films = try JSONDecoder().decode(SearchResponse.self, from: data)
                    response(films)
                } catch let jsonError {
                    print("Failed to decode JSON", jsonError)
                    response(nil)
                }
            case .failure(let error):
                print("Error received requesting data: \(error.localizedDescription)")
                response(nil)
            }
        }
    }
}
