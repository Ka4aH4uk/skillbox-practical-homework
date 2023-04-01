//
//  MainPresenter.swift
//  MVP
//
//  Created by Ka4aH on 29.03.2023.
//

import Foundation
import UIKit

protocol MainViewProtocol: AnyObject {
    func success()
    func showLoadingIndicator()
    func hideLoadingIndicator()
    func failure(error: Error)
}

protocol MainViewPresenterProtocol: AnyObject {
    init(view: MainViewProtocol, networkService: NetworkServiceProtocol)
    func getTracks(searchText: String, completion: ((Error?) -> Void)?)
    var track: [Results]? { get set }
}

final class MainPresenter: MainViewPresenterProtocol {
    weak var view: MainViewProtocol?
    let networkService: NetworkServiceProtocol!
    var track: [Results]?

    required init(view: MainViewProtocol, networkService: NetworkServiceProtocol) {
        self.view = view
        self.networkService = networkService
        getTracks(searchText: "", completion: nil)
    }

    func getTracks(searchText: String, completion: ((Error?) -> Void)? = nil) {
        let urlString = "https://itunes.apple.com/search?term=\(searchText)"
        networkService?.getTracks(urlString: urlString, completion: { [weak self] (result: Result<Tracks?, Error>) -> Void in
            guard let self = self else {return}
            DispatchQueue.main.async {
                switch result {
                case .success(let track):
                    guard track != nil else { return }
                    self.track = track?.results
                    self.view?.success()
                    completion?(nil)
                case .failure(let error):
                    completion?(error)
                }
            }
        })
    }
}
