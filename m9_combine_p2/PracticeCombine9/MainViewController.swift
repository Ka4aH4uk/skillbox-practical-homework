//
//  MainViewController.swift
//  PracticeCombine9
//
//  Created by Roman on 10.08.2022.
//

import UIKit
import Combine

class MainViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    private var originalImage: UIImage? = nil
    
    private var selectedImagePublisher: AnyPublisher<UIImage, Never>?
    private var cancellable = Set<AnyCancellable>()

    @IBAction func searchImageButtonPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let searchController = storyboard.instantiateViewController(withIdentifier: "searchControllerID") as! SearchViewController
        
        searchController.didSelectImagePublisher
            .sink { [weak self] image in
                self?.didSelectImage(image)
            }
            .store(in: &cancellable)
        
        selectedImagePublisher = searchController.didSelectImagePublisher
        
        self.present(searchController, animated: true)
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
    
    private func didSelectImage(_ image: UIImage) {
        self.originalImage = image
        self.imageView.image = image
    }
}
