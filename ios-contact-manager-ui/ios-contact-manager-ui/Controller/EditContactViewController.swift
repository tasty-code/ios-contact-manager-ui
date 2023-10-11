//
//  EditContactViewController.swift
//  ios-contact-manager-ui
//
//  Created by 김준성 on 2023/10/11.
//

import UIKit

final class EditContactViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
    }
    
    private func configureNavigationBar() {
        navigationItem.title = "새 연락처"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: nil, action: nil)
    }
}
