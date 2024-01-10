//
//  AddContanctViewController.swift
//  ios-contact-manager-ui
//
//  Created by Harry Ho on 1/10/24.
//

import UIKit

class AddContactViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationItem()
    }
    
    func configureNavigationItem() {
        let dismissButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonTapped))
        let saveButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveButtonTapped))
        
        navigationItem.leftBarButtonItem = dismissButton
        navigationItem.rightBarButtonItem = saveButton
        navigationItem.title = "새 연락처"
    }

    @objc func cancelButtonTapped() {
        presentAlertWithCancel(title: "정말로 취소하시겠습니까?", message: "", confirmTitle: "예", cancelTitle: "아니오") { [weak self] _ in self?.dismissModal() }
    }
    
    func dismissModal() {
        self.dismiss(animated: true)
    }
    
    @objc func saveButtonTapped() {
        self.dismiss(animated: true)
    }
}
