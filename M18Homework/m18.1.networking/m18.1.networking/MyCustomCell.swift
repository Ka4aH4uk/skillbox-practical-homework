//
//  MyCustomCell.swift
//  m18.1.networking
//
//  Created by Ka4aH on 20.02.2023.
//

import UIKit
import SnapKit

class MyCustomCell: UITableViewCell {
    
    let picture = UIImageView()
    let headerLabel = UILabel()
    let descriptionLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureContents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(_ viewModel: Films) {
        //picture.image = viewModel.
        headerLabel.text = viewModel.title
        descriptionLabel.text = viewModel.description
    }
    
    func configureContents() {
        contentView.addSubview(picture)
        picture.layer.masksToBounds = true
        picture.layer.cornerRadius = 8
        picture.snp.makeConstraints { make in
            make.height.equalTo(70)
            make.width.equalTo(50)
            make.left.equalToSuperview().inset(16)
            make.top.equalToSuperview().inset(16)
        }
        
        contentView.addSubview(headerLabel)
        headerLabel.textColor = .black
        headerLabel.font = .systemFont(ofSize: 22)
        headerLabel.snp.makeConstraints { make in
            make.height.equalTo(19)
            make.left.equalToSuperview().inset(82)
            make.top.equalToSuperview().inset(16)
        }
        
        contentView.addSubview(descriptionLabel)
        descriptionLabel.textColor = UIColor.darkGray
        descriptionLabel.font = .systemFont(ofSize: 16)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(24)
            make.left.equalToSuperview().inset(82)
            make.top.equalToSuperview().inset(43)
        }
    }
}

