//
//  ViewController.swift
//  M17_Concurrency
//
//  Created by Maxim NIkolaev on 08.12.2021.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    let service = Service()
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        //view.contentMode = .scaleAspectFit
        return view
    }()
    
    private var images = [UIImage]()
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fillEqually
        view.spacing = 10
        return view
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        //let view = UIActivityIndicatorView(frame: CGRect(x: 220, y: 220, width: 140, height: 140))
        let view = UIActivityIndicatorView(style: .large)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        onLoad()
    }

    private func onLoad() {
        print("---Central Dispatch Group---")
        let dispatchGroup = DispatchGroup()
        
        //формируем группу асинхронных операций
        for i in 0...4 {
            dispatchGroup.enter()
            print("Enter \(i), priority = \(qos_class_self().rawValue)")
            DispatchQueue.main.async(
                group: dispatchGroup,
                qos: .userInteractive,
                flags: [],
                execute: {
                    self.service.getImageURL { urlString, error in
                        guard
                            let urlString = urlString
                        else {
                            return
                        }
                        let image = self.service.loadImage(urlString: urlString)
                        self.images.append(image ?? UIImage())
                        dispatchGroup.leave()
                        print("Выход \(i), приоритет = \(qos_class_self().rawValue)")
                }
          //блок обратного вызова на всю группу
                    dispatchGroup.notify(queue: DispatchQueue.main) { [weak self] in
                        guard
                            let self = self
                        else {
                            return
                        }
                        self.activityIndicator.stopAnimating()
                        self.stackView.removeArrangedSubview(self.activityIndicator)
                        let view = UIImageView(image: UIImage())
                        view.contentMode = .scaleAspectFit
                        self.stackView.addArrangedSubview(view)
                        view.image = self.images[i]
                    }
                })
        }
    }
    
    private func setupViews() {
        view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)
//            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottomMargin)
//            make.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin)
//            make.left.right.equalToSuperview()
        }
        stackView.addArrangedSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
}

