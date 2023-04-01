//
//  DetailPresenter.swift
//  MVP
//
//  Created by Ka4aH on 29.03.2023.
//

import Foundation

protocol DetailViewProtocol: AnyObject {
    func setDetails(track: Results?)
}

protocol DetailViewPresenterProtocol: AnyObject {
    init(view: DetailViewProtocol, networkService: NetworkServiceProtocol, track: Results?)
    func setDetails()
}

final class DetailViewPresenter: DetailViewPresenterProtocol {
    weak var view: DetailViewProtocol?
    let networkService: NetworkServiceProtocol!
    var track: Results?
    
    required init(view: DetailViewProtocol, networkService: NetworkServiceProtocol, track: Results?) {
        self.view = view
        self.networkService = networkService
        self.track = track
        setDetails()
    }
    
    public func setDetails() {
        self.view?.setDetails(track: track)
    }
}
