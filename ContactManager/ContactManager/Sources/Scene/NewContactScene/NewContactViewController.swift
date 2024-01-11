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
        presentAlertWithCancel(title: "정말로 취소하시겠습니까?", okButtonTitle: "예", cancelButtonTitle: "아니오", okAction: { [weak self] _ in
            self?.dismiss(animated: true)
        })
    }
}
