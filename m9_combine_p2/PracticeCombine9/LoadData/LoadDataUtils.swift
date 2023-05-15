//
//  LoadDataUtils.swift
//  PracticeCombine9
//
//  Created by Roman on 11.08.2022.
//

import Foundation
import UIKit

enum DataLoadError: Error {
    
    case emptyData
    
    case decodeError
    
    case imagesNotLoaded
    
    case sessionError(Error)
}

/// Метод ищет и загружает изображения по заданной поисковой строке
/// - Parameters:
///   - text: Строка для поиска
///   - completion: Замыкание с результатом, где находится массив UIImage, либо ошибка загрузки
func loadImages(by text: String, completion: @escaping (Result<[UIImage], DataLoadError>) -> Void) {
    guard let apiKey = Bundle.main.infoDictionary?["SearchAPIKey"] as? String else { return }
    guard let url = URL(string: "https://api.unsplash.com/search/photos/?client_id=\(apiKey)&per_page=20&query=\(text)") else { return }
    let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
        if let error = error {
            completion(.failure(.sessionError(error)))
            return
        }
        guard let data = data, !data.isEmpty else {
            completion(.failure(.emptyData))
            return
        }
        if let searchResults = try? JSONDecoder().decode(SearchResults.self, from: data) {
            startLoad(for: searchResults.imagesResults, completion: completion)
        } else {
            completion(.failure(.decodeError))
        }
    }

    task.resume()
}

private func startLoad(for imagesInfo: [ImageInfo], completion: @escaping (Result<[UIImage], DataLoadError>) -> Void) {
    let dispatchGroup = DispatchGroup()
    var images: [UIImage] = []
    
    imagesInfo.forEach {
        dispatchGroup.enter()
        
        let task = URLSession.shared.dataTask(with: $0.url.absoluteURL) { (data, _, _) in
            guard let data = data, let image = UIImage(data: data) else {
                return
            }
            images.append(image)
            dispatchGroup.leave()
        }

        task.resume()
    }
    
    dispatchGroup.notify(queue: .global()) {
        if images.isEmpty {
            completion(.failure(.imagesNotLoaded))
        } else {
            completion(.success(images))
        }
    }
}
