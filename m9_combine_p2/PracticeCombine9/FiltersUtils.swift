//
//  FiltersUtils.swift
//  PracticeCombine9
//
//  Created by Roman on 11.08.2022.
//

import Foundation
import UIKit

private let filterNames = [
    "CIPhotoEffectChrome",
    "CIPhotoEffectFade",
    "CIPhotoEffectInstant",
    "CIPhotoEffectMono",
    "CIPhotoEffectNoir",
    "CIPhotoEffectProcess",
    "CIPhotoEffectTonal",
    "CIPhotoEffectTransfer",
    "CISepiaTone",
]

/// Применяет к изображениею случайновыбранные фильтры.
/// - Parameters:
///   - image: Исходное изображение
///   - completion: Замыкание с результирующим изображением.
func applyRandomFilters(to image: UIImage, completion: @escaping (UIImage) -> Void) {
    // Используем от одного до четырех доступных фильтров, выбираем их случайным образом
    let filtersCount = Int.random(in: (1...4))
    let filtersNames = Array(filterNames.shuffled().dropLast(filterNames.count - filtersCount))
                        
    applyFilters(filtersNames, to: image) { filteredImage in
        completion(filteredImage)
    }
}

private func applyFilters(_ filtersNames: [String], to image: UIImage, completion: @escaping (UIImage) -> Void) {
    DispatchQueue.global().async {
        var filteredImage: UIImage = image
        filtersNames.forEach {
            filteredImage = filteredImage.applyFilter($0)
        }
        DispatchQueue.main.async {
            completion(filteredImage)
        }
    }
}

private extension UIImage {
    
    /// Применяет к изображению фильтр с переданным именем.
    /// - Parameter filterName: Имя фильтра.
    /// - Returns: Изображение с примененным фильтром.
    func applyFilter(_ filterName: String) -> UIImage {
        let ciContext = CIContext(options: nil)
        let coreImage = CIImage(image: self)
        let filter = CIFilter(name: filterName)
        filter!.setDefaults()
        filter!.setValue(coreImage, forKey: kCIInputImageKey)
        let filteredImageData = filter!.value(forKey: kCIOutputImageKey) as! CIImage
        guard let filteredImageRef = ciContext.createCGImage(filteredImageData, from: filteredImageData.extent) else {
            return self
        }
        return UIImage(cgImage: filteredImageRef)
    }
}
