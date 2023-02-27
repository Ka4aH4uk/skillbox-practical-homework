//
//  AddEditArtistViewController.swift
//  m19
//
//  Created by Ka4aH on 27.02.2023.
//

import UIKit
import SnapKit

class AddEditArtistViewController: ViewController {
    
    //MARK: -- Views
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "1. Имя исполнителя"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .white
        return label
    }()
    
    private lazy var nameTF: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .left
        textField.font = UIFont.systemFont(ofSize: 18)
        textField.borderStyle = .roundedRect
        textField.clearButtonMode = .whileEditing
        textField.backgroundColor = .white
        return textField
    }()
    
    private lazy var lastnameLabel: UILabel = {
        let label = UILabel()
        label.text = "2. Фамилия исполнителя"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .white
        return label
    }()
    
    private lazy var lastnameTF: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .left
        textField.font = UIFont.systemFont(ofSize: 18)
        textField.borderStyle = .roundedRect
        textField.clearButtonMode = .whileEditing
        textField.backgroundColor = .white
        return textField
    }()
    
    private lazy var birthLabel: UILabel = {
        let label = UILabel()
        label.text = "3. Дата рождения исполнителя"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .white
        return label
    }()
    
    private lazy var birthTF: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .left
        textField.font = UIFont.systemFont(ofSize: 18)
        textField.borderStyle = .roundedRect
        textField.clearButtonMode = .whileEditing
        textField.backgroundColor = .white
        return textField
    }()
    
    private lazy var countryLabel: UILabel = {
        let label = UILabel()
        label.text = "4.Страна исполнителя"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .white
        return label
    }()
    
    private lazy var countryTF: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .left
        textField.font = UIFont.systemFont(ofSize: 18)
        textField.borderStyle = .roundedRect
        textField.clearButtonMode = .whileEditing
        textField.backgroundColor = .white
        return textField
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 300, height: 50))
        button.setTitle("Сохранить", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.backgroundColor = .systemRed
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.alignment = .fill
        stackView.spacing = 10
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(nameTF)
        stackView.addArrangedSubview(lastnameLabel)
        stackView.addArrangedSubview(lastnameTF)
        stackView.addArrangedSubview(birthLabel)
        stackView.addArrangedSubview(birthTF)
        stackView.addArrangedSubview(countryLabel)
        stackView.addArrangedSubview(countryTF)
        stackView.addArrangedSubview(saveButton)
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
// MARK: - Private
    
    private func setupViews() {
        view.addSubview(stackView)
    }
    
    private func setupConstraints() {
        stackView.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottomMargin).inset(310)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leadingMargin).inset(10)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailingMargin).inset(10)
        }
    }
}

extension AddEditArtistViewController: UITextFieldDelegate {
    
}






