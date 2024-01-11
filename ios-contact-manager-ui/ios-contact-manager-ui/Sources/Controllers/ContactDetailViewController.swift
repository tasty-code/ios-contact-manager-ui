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
        
    }
    
    @objc func setupButtonAction() {
        
    }
}
