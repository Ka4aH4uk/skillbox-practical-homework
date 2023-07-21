//
//  SearchResponse.swift
//  m18.1.networking
//
//  Created by Ka4aH on 20.02.2023.
//  https://app.quicktype.io/

import Foundation

// MARK: - SearchResponse
struct SearchResponse: Decodable {
    let resultCount: Int?
    let results: [Tracks]?
}

// MARK: - Result
struct Tracks: Decodable {
    let artistName: String
    let collectionName, trackName, collectionCensoredName, trackCensoredName: String?
    let artistViewURL, collectionViewURL, trackViewURL: String?
    let artworkUrl30: String?
    let artworkUrl60, artworkUrl100: String
    let primaryGenreName: String
    let copyright, description: String?
    let collectionArtistName: String?
    let collectionArtistViewURL: String?
    let contentAdvisoryRating: String?
    let shortDescription, longDescription: String?
}
