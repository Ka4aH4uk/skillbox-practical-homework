//
//  DetailViewModel.swift
//  MVVM
//
//  Created by Ka4aH on 02.04.2023.
//

import Foundation

protocol DetailViewModelProtocol {
    var track: Box<Results?> { get }
    func fetchTrackDetails()
}

final class DetailViewModel: DetailViewModelProtocol {
    var track = Box<Results?>(nil)
    private let networkService: NetworkServiceProtocol

    init(networkService: NetworkServiceProtocol, track: Results?) {
        self.networkService = networkService
        self.track.value = track
    }

    func fetchTrackDetails() {
        guard let track = track.value, let trackId = track.trackID else { return }
        let urlString = "https://itunes.apple.com/lookup?id=\(trackId)"
        networkService.getTracks(urlString: urlString) { [weak self] result in
            switch result {
            case .success(let tracks):
                guard let track = tracks?.results?.first else { return }
                self?.track.value = track
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
