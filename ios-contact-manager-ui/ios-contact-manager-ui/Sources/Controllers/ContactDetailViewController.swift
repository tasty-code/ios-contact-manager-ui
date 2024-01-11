//
//  ContactDetailViewController.swift
//  ios-contact-manager-ui
//
//  Created by Lee minyeol on 1/11/24.
//

import UIKit

class ContactDetailViewController: UIViewController {

    private let detailView = DetailView()
    var contact: Contact?
    
    lazy var navigationBar: UINavigationBar = {
        let nvBar = UINavigationBar()
        nvBar.translatesAutoresizingMaskIntoConstraints = false
        return nvBar
    }()
    
    override func loadView() {
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupnvBar()
        detailView.contact = contact

    }

    func setupnvBar() {
        self.view.backgroundColor = .white
        
        self.view.addSubview(navigationBar)
        let safeArea = self.view.safeAreaLayoutGuide
        
        navigationBar.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        navigationBar.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        navigationBar.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
        
        let leftButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonTapped))
        let rtButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(setupButtonAction))
        
        let navItem = UINavigationItem(title: "새연락처")
        navItem.leftBarButtonItem = leftButton
        navItem.rightBarButtonItem = rtButton
        navigationBar.setItems([navItem], animated: true)
    }
    
    @objc func cancelButtonTapped() {
        present(showErrorAlert(title: "정말 취소하시겠습니까?", nil, actions: [UIAlertAction(title: "예", style: .cancel, handler: { _ in
            self.dismiss(animated: true)
        }), UIAlertAction(title: "아니오", style: .destructive)]), animated: true)
    }
    
    @objc func setupButtonAction() {
        
    }
}
