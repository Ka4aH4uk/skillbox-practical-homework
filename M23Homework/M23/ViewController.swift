//
//  ViewController.swift
//  M23
//
//  Created by Maxim NIkolaev on 09.03.2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .red
    }
    
    func onButton() {
        navigationController?.pushViewController(UIViewController(), animated: true)
    }
    
}

