//
//  ViewController.swift
//  Skillbox 14 ДЗ
//
//  Created by Алёша on 21.05.2020.
//  Copyright © 2020 Алёша. All rights reserved.
//

import UIKit
import CoreData



class ViewController: UIViewController {
    @IBOutlet var defaultLabel: UILabel!
    
    @IBOutlet var userNameTextField: UITextField!
    @IBOutlet var userSurnameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        defaultLabel.text = "Текущее имя: \(Persistence.shared.userName ?? "-")\n Текущая фамилия: \(Persistence.shared.userSurname ?? "-")"

    }
    
    
    @IBAction func userNameTextFieldAction(_ sender: Any) {
        Persistence.shared.userName = userNameTextField.text
        defaultLabel.text = "Текущее имя: \(Persistence.shared.userName ?? "")\n Текущая фамилия: \(Persistence.shared.userSurname ?? "")"    }
    
    @IBAction func userSurnameTextFieldAction(_ sender: Any) {
        Persistence.shared.userSurname = userSurnameTextField.text
        defaultLabel.text = "Текущее имя: \(Persistence.shared.userName ?? "")\n Текущая фамилия: \(Persistence.shared.userSurname ?? "")"    }
    
    
}

