//
//  Box.swift
//  MVVM
//
//  Created by Ka4aH on 05.04.2023.
//

import Foundation

final class Box<T> {
    typealias Listener = (T) -> Void
    var listener: Listener?

    func bind(listener: Listener?) {
        self.listener = listener
        listener?(value)
    }

    var value: T {
        didSet {
            listener?(value)
        }
    }

    init(_ value: T) {
        self.value = value
    }
}
