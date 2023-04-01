//
//  SearchResponse.swift
//  MVP
//
//  Created by Ka4aH on 22.03.2023.
//

import Foundation

// MARK: - Tracks
struct Tracks: Codable {
    let resultCount: Int?
    let results: [Results]?
}

// MARK: - Result
struct Results: Codable {
    let artistName, collectionName, trackName, collectionCensoredName: String?
    let trackCensoredName: String?
    let collectionArtistID: Int?
    let collectionArtistViewURL, collectionViewURL, trackViewURL: String?
    let previewURL: String?
    let artworkUrl30, artworkUrl60, artworkUrl100: String?
    let collectionPrice, trackPrice, trackRentalPrice, collectionHDPrice: Double?
    let trackHDPrice, trackHDRentalPrice: Double?
    let shortDescription, longDescription: String?
}
