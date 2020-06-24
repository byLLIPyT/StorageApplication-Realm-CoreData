//
//  ViewController.swift
//  StorageApplication
//
//  Created by Александр Уткин on 15.06.2020.
//  Copyright © 2020 Александр Уткин. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var surnameLabel: UITextField!
    
    let nameKey = "nameTextValue"
    let surnameKey = "surnameTextValue"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadValue()
    }

    private func loadValue() {
        
        nameLabel.text = UserDefaults.standard.string(forKey: nameKey)
        surnameLabel.text = UserDefaults.standard.string(forKey: surnameKey)
    }

    @IBAction func saveButton(_ sender: Any) {
        
        UserDefaults.standard.set(nameLabel.text, forKey: nameKey)
        UserDefaults.standard.set(surnameLabel.text, forKey: surnameKey)
    }
}

