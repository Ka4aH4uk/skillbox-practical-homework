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
        
    }
    
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
        let alert = UIAlertController(title: "Success", message: "Данные успешно отправлены", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    private func showAlertFailure() {
        let alert = UIAlertController(title: "Error", message: "Что-то пошло не так", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}


