//
//  ContactDetailViewController.swift
//  ios-contact-manager-ui
//
//  Created by Lee minyeol on 1/11/24.
//

import UIKit

protocol ContactDetailDelegate: AnyObject {
    func add(contact: Contact)
}

final class ContactDetailViewController: UIViewController {

    private let detailView = DetailView()
    var contact: Contact?
    weak var delegate: ContactDetailDelegate?
    
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

    private func setupnvBar() {
        self.view.backgroundColor = .white
        
        self.view.addSubview(navigationBar)
        let safeArea = self.view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            navigationBar.topAnchor.constraint(equalTo: safeArea.topAnchor),
            navigationBar.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
        ])
        
        let leftButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonTapped))
        let rtButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(setupButtonAction))
        
        let navItem = UINavigationItem(title: "새연락처")
        navItem.leftBarButtonItem = leftButton
        navItem.rightBarButtonItem = rtButton
        navigationBar.setItems([navItem], animated: true)
    }
    
    @objc func cancelButtonTapped() {
        let alert = showErrorAlert(title: nil, "정말 취소하시겠습니까?", actions: [UIAlertAction(title: "예", style: .cancel, handler: { _ in
            self.dismiss(animated: true)
        }), UIAlertAction(title: "아니오", style: .destructive)])
        present(alert, animated: true)
    }
    
    @objc func setupButtonAction() {
        do {
            let (name, age, phone) = try makeInfo()
            let new = Contact(name: name, phoneNumber: phone, age: age)
            delegate?.add(contact: new)
            self.dismiss(animated: true)
        } catch {
            let alert = showErrorAlert(title: nil, error.localizedDescription, actions: [UIAlertAction(title: "확인", style: .default)])
            present(alert, animated: true)
        }
    }
}

// MARK: - Verification

extension ContactDetailViewController {
    func makeInfo() throws -> (String, String, String) {
        guard let name = detailView.nameTextField.text, Verification.setName(name) else { throw ContactError.errorName }
        guard let age = detailView.ageTextField.text, Verification.setAge(age) else { throw ContactError.errorAge }
        guard let phone = detailView.phoneNumberTextField.text, Verification.setNumber(phone) else { throw ContactError.errorNumber }
        
        return (name.removeBlank, age, phone)
    }
}
