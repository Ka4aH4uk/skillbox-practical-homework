//
//  SearchResponse.swift
//  m18.1.networking
//
//  Created by Ka4aH on 20.02.2023.
//

import Foundation

// MARK: - SearchResponse
struct SearchResponse: Decodable {
    var searchType, expression: String
    var results: [Films]
    var errorMessage: String
}

// MARK: - Result
struct Films: Decodable {
    var id: String
    var resultType: String
    var image: String?
    var title: String
    var description: String
}
