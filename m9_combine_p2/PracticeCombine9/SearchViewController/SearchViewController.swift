//
//  SearchViewController.swift
//  PracticeCombine9
//
//  Created by Roman on 10.08.2022.
//

import Foundation
import UIKit
import Combine

class SearchViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicatorVIew: UIActivityIndicatorView!
    
    private let didSelectImageSubject = PassthroughSubject<UIImage, Never>()
    
    var didSelectImagePublisher: AnyPublisher<UIImage, Never> {
        return didSelectImageSubject.eraseToAnyPublisher()
    }
    
    private var cancellable = Set<AnyCancellable>()

    private var images: [UIImage] = []
    
    private let itemsOnRow: CGFloat = 2
    private let sectionInsets = UIEdgeInsets(top: 24.0, left: 24.0, bottom: 24.0, right: 24.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addObserverForTextField()
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        self.collectionView.isHidden = true
        self.activityIndicatorVIew.isHidden = true
    }
    
    private func addObserverForTextField() {
        NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: self.textField)
            .compactMap { ($0.object as? UITextField)?.text }
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] text in
                self?.searchImages(by: text)
            }
            .store(in: &cancellable)
    }
    
    private func searchImages(by text: String) {
        guard !text.isEmpty else { return }
        self.collectionView.isHidden = true
        self.activityIndicatorVIew.isHidden = false
        
        loadImages(by: text)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    let alert = UIAlertController(title: "Ошибка", message: "\(error)", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel))
                    self?.present(alert, animated: true, completion: nil)
                case .finished:
                    break
                }
                self?.activityIndicatorVIew.isHidden = true
            } receiveValue: { [weak self] images in
                self?.images = images
                self?.collectionView.reloadData()
                self?.collectionView.isHidden = false
            }
            .store(in: &cancellable)
    }
    
    private func didSelectImage(_ image: UIImage) {
        didSelectImageSubject.send(image)
    }
}

extension SearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.images.count
    }
  
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellReuseIdentifier", for: indexPath) as! SearchViewControllerCell
        cell.imageView.image = self.images[indexPath.row]
        return cell
    }
    
}

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsOnRow + 1)
        let availableWidth = collectionView.frame.width - paddingSpace
        let widthPerItem = floor(availableWidth / itemsOnRow)
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}

extension SearchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard indexPath.row < self.images.count else {
            return
        }
        self.didSelectImage(self.images[indexPath.row])
    }
}
