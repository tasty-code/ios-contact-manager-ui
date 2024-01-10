//
//  NewContactViewController.swift
//  ContactManager
//
//  Created by EUNJU on 2024/01/10.
//

import UIKit

final class NewContactViewController: UIViewController {

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK: @IBAction
    @IBAction private func tapCancelButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true)
    }
}
