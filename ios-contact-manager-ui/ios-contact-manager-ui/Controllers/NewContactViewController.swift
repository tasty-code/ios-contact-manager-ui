//
//  NewContactViewController.swift
//  ios-contact-manager-ui
//
//  Created by 김진웅 on 2023/10/10.
//

import UIKit

class NewContactViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
    }
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
    }
}
