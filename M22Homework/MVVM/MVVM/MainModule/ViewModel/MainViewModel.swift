//
//  MainViewModel.swift
//  MVVM
//
//  Created by Ka4aH on 02.04.2023.
//

import Foundation

protocol MainViewModelProtocol {
    var searchText: Box<String> { get }
    var tracks: Box<[Results]> { get }
    var loading: Box<Bool> { get }
    func searchTracks()
}

final class MainViewModel: MainViewModelProtocol {
    var searchText = Box("")
    var tracks = Box([Results]())
    var loading = Box(false)

    private let networkService: NetworkServiceProtocol

    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }

    func searchTracks() {
        guard let searchText = searchText.value.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        let urlString = "https://itunes.apple.com/search?term=\(searchText)"
        loading.value = true
        networkService.getTracks(urlString: urlString) { [weak self] result in
            switch result {
            case .success(let tracks):
                guard let tracks = tracks?.results else { return }
                self?.tracks.value = tracks
            case .failure(let error):
                print(error.localizedDescription)
            }
            self?.loading.value = false
        }
    }
}
