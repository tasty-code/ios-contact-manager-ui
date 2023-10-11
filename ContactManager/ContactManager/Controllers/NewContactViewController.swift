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
        let alertController = UIAlertController(title: "정말로 취소하시겠습니까?",
                          message: nil,
                          preferredStyle: .alert)
        let noAlertAction = UIAlertAction(title: "아니오", style: .default, handler: nil)
        let yesAlertAction = UIAlertAction(title: "예", style: .destructive, handler: { _ in
            self.dismiss(animated: true)
        })
        
        alertController.addAction(noAlertAction)
        alertController.addAction(yesAlertAction)
        present(alertController, animated: true)
    }
}
