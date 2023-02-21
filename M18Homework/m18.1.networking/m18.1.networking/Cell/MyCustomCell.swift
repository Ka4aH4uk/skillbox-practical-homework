//
//  MyCustomCell.swift
//  m18.1.networking
//
//  Created by Ka4aH on 20.02.2023.
//

import UIKit
import SnapKit

class MyCustomCell: UITableViewCell {
    
    var poster = UIImageView()
    let headerLabel = UILabel()
    let descriptionLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureContents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureContents() {
        contentView.addSubview(poster)
        poster.contentMode = .scaleAspectFit
        poster.layer.masksToBounds = true
        poster.layer.cornerRadius = 8
        poster.snp.makeConstraints { make in
            make.height.equalTo(70)
            make.width.equalTo(50)
            make.left.equalToSuperview().inset(16)
            make.top.equalToSuperview().inset(12)
        }
        
        contentView.addSubview(headerLabel)
        headerLabel.textColor = .white
        headerLabel.font = .systemFont(ofSize: 22)
        headerLabel.snp.makeConstraints { make in
            make.height.equalTo(25)
            make.left.equalToSuperview().inset(82)
            make.right.equalToSuperview().inset(16)
            make.top.equalToSuperview().inset(12)
        }
        
        contentView.addSubview(descriptionLabel)
        descriptionLabel.textColor = .lightGray
        descriptionLabel.font = .systemFont(ofSize: 16)
        descriptionLabel.numberOfLines = 2
        descriptionLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(24)
            make.left.equalToSuperview().inset(82)
            make.top.equalToSuperview().inset(43)
        }
    }
}

