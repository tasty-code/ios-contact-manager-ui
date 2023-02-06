//
//  AddContactViewController.swift
//  ContactManagerUI
//
//  Created by 이상윤 on 2023/02/06.
//

import UIKit

class AddContactViewController: UIViewController {

    var newContactNavigationBar: UINavigationBar = {
        let navigationBar = UINavigationBar()
        let navigationItem = UINavigationItem(title: "새 연락처")
        let cancelItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: nil, action: nil)
        let saveItem = UIBarButtonItem(barButtonSystemItem: .save, target: nil, action: nil)
        navigationItem.leftBarButtonItem = cancelItem
        navigationItem.rightBarButtonItem = saveItem
        navigationBar.setItems([navigationItem], animated: false)
        return navigationBar
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubview()
        configureLayout()
    }

    private func addSubview() {
        view.addSubview(newContactNavigationBar)
    }
    
    private func configureLayout() {
        let safeArea = view.safeAreaLayoutGuide

        newContactNavigationBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            newContactNavigationBar.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            newContactNavigationBar.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            newContactNavigationBar.topAnchor.constraint(equalTo: safeArea.topAnchor),
            newContactNavigationBar.widthAnchor.constraint(equalTo: view.widthAnchor),
        ])
    }

}
