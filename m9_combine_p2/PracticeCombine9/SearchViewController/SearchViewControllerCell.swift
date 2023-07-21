//
//  SearchViewControllerCell.swift
//  PracticeCombine9
//
//  Created by Roman on 10.08.2022.
//

import Foundation
import UIKit

class SearchViewControllerCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override var isSelected: Bool {
        didSet {
            self.startAnimation()
        }
    }
    
    private func startAnimation() {
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseOut, animations: {
            self.layer.zPosition = self.isSelected ? 1 : -1
            self.imageView.alpha = self.isSelected ? 0.5 : 1
            self.transform = self.isSelected ? CGAffineTransform(scaleX: 1.2, y: 1.2) : CGAffineTransform.identity
        }, completion: { _ in
            UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseOut, animations: {
                self.layer.zPosition = self.isSelected ? 1 : -1
                self.imageView.alpha = 1
                self.transform = CGAffineTransform.identity
            }, completion: nil)
        })
    }
}
