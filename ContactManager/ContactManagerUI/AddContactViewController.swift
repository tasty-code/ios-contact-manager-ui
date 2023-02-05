//
//  AddContactViewController.swift
//  ContactManagerUI
//
//  Created by DONGWOOK SEO on 2023/02/01.
//

import UIKit

final class AddContactViewController: UIViewController {
    
    
    @IBOutlet weak private var nameTextField: UITextField!
    @IBOutlet weak private var ageTextField: UITextField!
    @IBOutlet weak private var phoneNumberTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction private func tappedCancelButton(_ sender: UIBarButtonItem) {
    }
    
    
    @IBAction private func tappedSaveButton(_ sender: UIBarButtonItem) {
    }
}
