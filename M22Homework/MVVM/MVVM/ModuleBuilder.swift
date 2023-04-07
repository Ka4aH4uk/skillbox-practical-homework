//
//  ModuleBuilder.swift
//  MVVM
//
//  Created by Ka4aH on 05.04.2023.
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
        let viewModel: MainViewModelProtocol = MainViewModel(networkService: networkService)
        view.viewModel = viewModel
        return view
    }

    static func createDetailModule(track: Results) -> UIViewController {
        let view = DetailViewController()
        let networkService: NetworkServiceProtocol = NetworkService()
        let viewModel: DetailViewModelProtocol = DetailViewModel(networkService: networkService, track: track)
        view.viewModel = viewModel
        return view
    }
}
