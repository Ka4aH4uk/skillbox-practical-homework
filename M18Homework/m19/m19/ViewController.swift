//
//  ViewController.swift
//  m19
//
//  Created by Ka4aH on 21.02.2023.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    var birthTF: Int = 0
    @IBAction func birthEditing(_ sender: UITextField) {
        birthTF = Int(sender.text ?? "") ?? 0
    }
    @IBOutlet weak var birthTextField: UITextField!
    
    var occuppationTF: String = ""
    @IBAction func occupationEditing(_ sender: UITextField) {
        occuppationTF = sender.text ?? ""
    }
    
    var nameTF: String = ""
    @IBAction func nameEditing(_ sender: UITextField) {
        nameTF = sender.text ?? ""
    }
    
    var lastnameTF: String = ""
    @IBAction func lastnameEditing(_ sender: UITextField) {
        lastnameTF = sender.text ?? ""
    }
    
    var countryTF: String = ""
    @IBAction func countryEditing(_ sender: UITextField) {
        countryTF = sender.text ?? ""
    }
    
    
    @IBAction func urlButton(_ sender: Any) {
        sendRequestWithURLSession()
    }
    
    @IBAction func alamofireButton(_ sender: Any) {
        sendRequestWithAlamofire()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        birthTextField.delegate = self
    }
    
    //MARK: -- URLSession
    func sendRequestWithURLSession() {
        // Создаем модель
        let model = Character(birth: birthTF, occupation: occuppationTF, name: nameTF, lastname: lastnameTF, country: countryTF)
        
        // Превращаем в JSON
        let jsonModel = try? JSONSerialization.data(withJSONObject: model.dictionaryRepresentation())
        
        // Настраиваем запрос
        var request = URLRequest(url: URL(string: "https://jsonplaceholder.typicode.com/posts")!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonModel
        
        //Делаем запрос и обрабатываем ответ
        URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    self?.showAlertFailure()
                }
                return
            }
            DispatchQueue.main.async {
                self?.showAlertAccess()
            }

            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                print(responseJSON)
            }
        }.resume()
    }
        
    //MARK: -- Alamofire
    func sendRequestWithAlamofire() {
        // Создаем модель
        let character = Character(birth: birthTF, occupation: occuppationTF, name: nameTF, lastname: lastnameTF, country: countryTF)

        AF.request(
            "https://jsonplaceholder.typicode.com/posts",
            method: .post,
            parameters: character,
            encoder: JSONParameterEncoder.default
        ).response { [weak self] response in
            guard response.error == nil else {
                self?.showAlertFailure()
                return
            }
            self?.showAlertAccess()
            debugPrint(response)
        }
    }
    
    private func showAlertAccess() {
        let alert = UIAlertController(title: "Success", message: "Поздравляем. Данные успешно отправлены.", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    private func showAlertFailure() {
        let alert = UIAlertController(title: "Error", message: "Что-то пошло не так. Повторите попытку.", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}

//MARK: -- UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
    
    //Дата рождения ограничена только вводом 4 цифр
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let maxLenght = 4
        let allowedCharacters = "1234567890"
        
        let newLength: Int = textField.text!.count + string.count - range.length
        let numberOnly = NSCharacterSet.init(charactersIn: allowedCharacters).inverted
        let strValid = string.rangeOfCharacter(from: numberOnly) == nil
        return (strValid && (newLength <= maxLenght))
    }
}

