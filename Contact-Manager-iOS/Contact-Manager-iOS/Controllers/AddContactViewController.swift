//
//  AddContactViewController.swift
//  Contact-Manager-iOS
//
//  Created by nayeon  on 2024/01/12.
//

import UIKit

final class AddContactViewController: UIViewController {
    
    //MARK: - Property
    private var contactManager: ContactManager
    private let addContactView = PersonalContactDetailView()
    
    
    //MARK: - Initializer
    init(contactManager: ContactManager) {
        self.contactManager = contactManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = addContactView
        
        configureNavigationBar()
    }
    
    
    //MARK: - Method
    private func configureNavigationBar() {
        title = "새 연락처"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveTapped))
    }
    
    @objc private func cancelTapped() {
        showCancelAlert()
    }
    
    @objc private func saveTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    private func showCancelAlert() {
        let alert = UIAlertController(title: "정말로 취소하시겠습니까?",
                                      message: nil,
                                      preferredStyle: .alert)
        
        let confirm = UIAlertAction(title: "예", style: .default) { [weak self] _ in
            self?.dismiss(animated: true, completion: nil)
        }
        let close = UIAlertAction(title: "아니요", style: .destructive)
        
        alert.addAction(confirm)
        alert.addAction(close)
        present(alert, animated: true, completion: nil)
    }
    
}
