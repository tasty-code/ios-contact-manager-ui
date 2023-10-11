//
//  NewContactViewController.swift
//  ContactManager
//
//  Created by imseonghyeon on 2023/10/11.
//

import UIKit

class NewContactViewController: UIViewController {

    @IBOutlet weak var cancelButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func touchUpCancelButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    
}
