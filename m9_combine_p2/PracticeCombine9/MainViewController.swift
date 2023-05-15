//
//  MainViewController.swift
//  PracticeCombine9
//
//  Created by Roman on 10.08.2022.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    private var originalImage: UIImage? = nil

    @IBAction func searchImageButtonPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let searchController = storyboard.instantiateViewController(withIdentifier: "searchControllerID") as! SearchViewController
        searchController.delegate = self
        self.present(searchController, animated: true, completion: nil)
    }
    
    @IBAction func filterItButtonPressed(_ sender: Any) {
        guard let originalImage = self.originalImage else {
            return
        }
        applyRandomFilters(to: originalImage) { [weak self] filteredImage in
            self?.imageView.image = filteredImage
        }
    }
    
    @IBAction func shareItButtonPressed(_ sender: Any) {
        let imageToShare = [self.imageView.image]
        let activityViewController = UIActivityViewController(activityItems: imageToShare as [Any], applicationActivities: nil)
        self.present(activityViewController, animated: true, completion: nil)
    }
    
}

extension MainViewController: SearchViewControllerDelegate {
     
    func didSelectImage(_ image: UIImage) {
        self.originalImage = image
        self.imageView.image = image
    }
}

