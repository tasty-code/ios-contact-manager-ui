//
//  NewContactViewController.swift
//  ContactManagerUI
//
//  Created by jun on 2023/02/07.
//

import UIKit

final class NewContactViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func cancelButtonDidTap(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "정말로 취소하시겠습니까?", message: nil, preferredStyle: .alert)
        let noButton = UIAlertAction(title: "아니오", style: .default)
        alert.addAction(noButton)
        let yesButton = UIAlertAction(title: "예", style: .destructive, handler: { _ in
            self.dismiss(animated: true)
        })
        alert.addAction(yesButton)
        present(alert, animated: true)
    }
}
