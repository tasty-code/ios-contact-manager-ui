//
//  AddNewContactViewController.swift
//  ContactManagerUI
//
//  Created by Blu on 2023/02/07.
//

import UIKit

class AddNewContactViewController: UIViewController {

    @IBAction func tappedCancelButton(_ sender: UIBarButtonItem) {
        failiureAlert()
    }

    @IBAction func tappedSaveButton(_ sender: UIBarButtonItem) {
        successAlert()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension AddNewContactViewController {
    private func successAlert() {
        let success = UIAlertAction(title: "확인", style: .default, handler: nil)
        let alert = UIAlertController(title: nil, message: "Error Case Message 출력", preferredStyle: .alert)
        
        alert.addAction(success)
        present(alert, animated: true, completion: nil)
    }
    
    private func failiureAlert() {
        let alert = UIAlertController(title: nil, message: "정말로 취소하시겠습니까?", preferredStyle: .alert)
        let allowAction = UIAlertAction(title: "예", style: .destructive, handler: { action in
            self.dismiss(animated: true)
        })
        let cancleAction = UIAlertAction(title: "아니오", style: .cancel, handler: nil)
        
        alert.addAction(allowAction)
        alert.addAction(cancleAction)
        present(alert, animated: true, completion: nil)
    }
}
