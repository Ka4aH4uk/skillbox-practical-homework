//
//  ImagesInfo.swift
//  PracticeCombine9
//
//  Created by Roman on 10.08.2022.
//

import Foundation

/// Модель данных, возвращаемая сервисом поиска изображений
struct SearchResults: Decodable {
    
    /// Массив найденных описаний изображений
    let imagesResults: [ImageInfo]
    
    enum CodingKeys: String, CodingKey {
        case results = "results"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.imagesResults = try container.decode([ImageInfo].self, forKey: .results)
    }
}

/// Модель данных одного изображения из результатов поиска
struct ImageInfo: Decodable {
    
    /// Ссылка на изображение
    let url: URL
    
    enum CodingKeys: String, CodingKey {
        case urls = "urls"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let dictionary: [String: URL] = try container.decode([String: URL].self, forKey: .urls)
        // Документация говорит о том, что если информация о картинке вернулась, то все ссылки в словаре есть, force unwrap допустим.
        self.url = dictionary["regular"]!
    }
}
