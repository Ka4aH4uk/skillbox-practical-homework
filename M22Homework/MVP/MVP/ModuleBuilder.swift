//
//  ModuleBuilder.swift
//  MVP
//
//  Created by Ka4aH on 29.03.2023.
//

import UIKit

protocol Builder {
    static func createMainModule() -> UIViewController
    static func createDetailModule(track: Results) -> UIViewController
}

struct ModuleBuilder: Builder {
    static func createMainModule() -> UIViewController {
        let view = MainViewController()
        let networkService: NetworkServiceProtocol = NetworkService()
        let presenter: MainViewPresenterProtocol = MainPresenter(view: view, networkService: networkService)
        view.presenter = presenter
        return view
    }

    static func createDetailModule(track: Results) -> UIViewController {
        let view = DetailViewController()
        let networkService: NetworkServiceProtocol = NetworkService()
        let presenter: DetailViewPresenterProtocol = DetailViewPresenter(view: view, networkService: networkService, track: track)
        view.presenter = presenter
        return view
    }
}
