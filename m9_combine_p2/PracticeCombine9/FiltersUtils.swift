//
//  FiltersUtils.swift
//  PracticeCombine9
//
//  Created by Roman on 11.08.2022.
//

import Foundation
import UIKit
import Combine

private var cancellable = Set<AnyCancellable>()

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

/// Применяет к изображению случайно выбранные фильтры.
/// - Parameters:
///   - image: Исходное изображение
///   - completion: Замыкание с результирующим изображением.
func applyRandomFilters(to image: UIImage, completion: @escaping (UIImage) -> Void) {
    let filtersCount = Int.random(in: (1...4))
    let filtersNames = Array(filterNames.shuffled().dropLast(filterNames.count - filtersCount))
    
    applyFilters(filtersNames, to: image)
        .receive(on: DispatchQueue.main)
        .sink { filteredImage in
            completion(filteredImage)
        }
        .store(in: &cancellable)
}

private func applyFilters(_ filtersNames: [String], to image: UIImage) -> AnyPublisher<UIImage, Never> {
    return filtersNames.publisher
        .flatMap(maxPublishers: .max(1)) { filterName in
            return Future<UIImage, Never> { promise in
                DispatchQueue.global().async {
                    let filteredImage = image.applyFilter(filterName)
                    promise(.success(filteredImage))
                }
            }
        }
        .collect()
        .map { images in
            return images.last ?? image
        }
        .eraseToAnyPublisher()
}

private extension UIImage {
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
