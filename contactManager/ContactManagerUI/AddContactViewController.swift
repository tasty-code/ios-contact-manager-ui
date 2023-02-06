//
//  AddContactViewController.swift
//  ContactManagerUI
//
//  Created by 이상윤 on 2023/02/06.
//

import UIKit

class AddContactViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureNavigationBar()
    }
    
    private func configureNavigationBar() {
        let navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 44))
        view.addSubview(navigationBar)
        
        let navigationItem = UINavigationItem(title: "새 연락처")
        let cancelItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: nil)
        let saveItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: nil)
        navigationItem.leftBarButtonItem = cancelItem
        navigationItem.rightBarButtonItem = saveItem
        
        navigationBar.setItems([navigationItem], animated: false)
    }

}
