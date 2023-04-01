//
//  DetailViewController.swift
//  MVP
//
//  Created by Ka4aH on 29.03.2023.
//

import UIKit
import SnapKit

final class DetailViewController: UIViewController {
    
    var presenter: DetailViewPresenterProtocol!
    
    private lazy var posterImage: UIImageView = {
        let image = UIImage()
        let view = UIImageView(image: image)
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private lazy var artistLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 26)
        label.numberOfLines = 2
        label.textColor = .systemPurple
        return label
    }()
    
    private lazy var albumLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 22)
        label.numberOfLines = 2
        label.textColor = .systemGreen
        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "AvenirNext-Regular", size: 20)
        label.numberOfLines = 0
        label.textColor = .white
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setDetails()
        setupViews()
    }
}

extension DetailViewController {
    private func setupViews() {
        view.backgroundColor = .black
        navigationController?.navigationBar.tintColor = .systemGreen
        view.addSubview(posterImage)
        posterImage.snp.makeConstraints { make in
            make.height.width.equalTo(300)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(100)
        }
        view.addSubview(artistLabel)
        artistLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(10)
            make.top.equalToSuperview().inset(420)
        }
        view.addSubview(albumLabel)
        albumLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(10)
            make.top.equalToSuperview().inset(455)
        }
        view.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(10)
            make.top.equalToSuperview().inset(520)
        }
    }
}

extension DetailViewController: DetailViewProtocol {
    func setDetails(track: Results?) {
        let queue = DispatchQueue.global(qos: .userInteractive)
        queue.async {
            let urlImage = URL(string: track!.artworkUrl100 ?? "")
            URLSession.shared.dataTask(with: urlImage!) { data, _, _ in
                guard let data = data else { return }
                DispatchQueue.main.async { [self] in
                    posterImage.image = UIImage(data: data)
                    artistLabel.text = track?.artistName
                    albumLabel.text = track?.collectionName
                    descriptionLabel.text = track?.longDescription
                }
            }.resume()
        }
    }
}
