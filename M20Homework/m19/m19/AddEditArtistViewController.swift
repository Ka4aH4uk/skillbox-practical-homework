//
//  AddEditArtistViewController.swift
//  m19
//
//  Created by Ka4aH on 27.02.2023.
//

import UIKit
import SnapKit
import CoreData


class AddEditArtistViewController: ViewController {
    
    var artists: Artists?
    
    //MARK: -- Views
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "1. Имя исполнителя *"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .white
        return label
    }()
    
    private lazy var nameTF: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .left
        textField.placeholder = "Keith"
        textField.font = UIFont.systemFont(ofSize: 18)
        textField.borderStyle = .roundedRect
        textField.clearButtonMode = .whileEditing
        textField.backgroundColor = .white
        return textField
    }()
    
    private lazy var lastnameLabel: UILabel = {
        let label = UILabel()
        label.text = "2. Фамилия исполнителя *"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .white
        return label
    }()
    
    private lazy var lastnameTF: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .left
        textField.placeholder = "Flint"
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
        textField.placeholder = "17.09.1969"
        textField.keyboardType = .numberPad
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
        textField.placeholder = "England"
        textField.font = UIFont.systemFont(ofSize: 18)
        textField.borderStyle = .roundedRect
        textField.clearButtonMode = .whileEditing
        textField.backgroundColor = .white
        return textField
    }()
    
    private lazy var warningLabel: UILabel = {
        let label = UILabel()
        label.text = "* Обязательные поля"
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .systemOrange
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
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
        stackView.addArrangedSubview(warningLabel)
        return stackView
    }()
    
    @IBAction func saveData(_ sender: UIBarButtonItem!) {
        if saveArtist() {
            navigationController?.popViewController(animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        birthTF.delegate = self
        setupViews()
        setupConstraints()
        if let artists = artists {
            nameTF.text = artists.name
            lastnameTF.text = artists.lastname
            birthTF.text = artists.birth
            countryTF.text = artists.country
        }
    }
    
    // MARK: - Private
    private func setupViews() {
        view.addSubview(stackView)
    }
    
    private func setupConstraints() {
        stackView.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottomMargin).inset(360)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leadingMargin).inset(10)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailingMargin).inset(10)
        }
    }
    
    private func saveArtist() -> Bool {
        // Проверка заполнення обязательных полей
        guard nameTF.text?.isEmpty == false && lastnameTF.text?.isEmpty == false else {
            let alert = UIAlertController(title: "Ошибка", message: "Пожалуйста, проверьте, что все обязательные поля заполнены правильно", preferredStyle: UIAlertController.Style.alert)
            alert.addAction (UIAlertAction(title: "OK", style: .cancel))
            self.present(alert, animated: true, completion: nil)
            return true
        }
        // Создание объекта
        if artists == nil {
            artists = Artists()
        }
        // Сохранение объекта
        if let artists = artists {
            artists.name = nameTF.text
            artists.lastname = lastnameTF.text
            artists.birth = birthTF.text
            artists.country = countryTF.text
            try? artists.managedObjectContext?.save()
            print("Save")
        }
        return true
    }
}

//MARK: -- UITextFieldDelegate
extension AddEditArtistViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
                
        if textField == birthTF {
            let numberOnly = NSCharacterSet.init(charactersIn: "0123456789").inverted
            let strValid = string.rangeOfCharacter(from: numberOnly) == nil
            if birthTF.text?.count == 2 || birthTF.text?.count == 5 {
                if !(string == "") {
                    birthTF.text = birthTF.text! + "."
                }
            }
            return (strValid && !(textField.text!.count > 9 && (string.count) > range.length))
        } else {
            return true
        }
    }
}
