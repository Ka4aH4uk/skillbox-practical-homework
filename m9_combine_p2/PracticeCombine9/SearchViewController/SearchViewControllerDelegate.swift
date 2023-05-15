//
//  SearchViewControllerDelegate.swift
//  PracticeCombine9
//
//  Created by Roman on 10.08.2022.
//

import Foundation
import UIKit

/// Протокол делегата SearchViewController'a
protocol SearchViewControllerDelegate {
    
    /// Вызывается при выборе изображения в SearchViewController
    /// - Parameter image: Выбранное изображение
    func didSelectImage(_ image: UIImage)
}
