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
    weak var delegate: ContactDelegate?
    
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
        detailView.phoneNumberTextField.addTarget(self, action: #selector(edit), for: .editingChanged)
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
        do {
            let (name, age, phone) = try makeInfo()
            let new = Contact(name: name, phoneNumber: phone, age: age)
            delegate?.add(contact: new)
            self.dismiss(animated: true)
        } catch {
            let alert = showErrorAlert(title: nil, error, actions: [UIAlertAction(title: "확인", style: .default)])
            present(alert, animated: true)
        }
    }
}

// MARK: - Verification
extension ContactDetailViewController: Verification {
    func makeInfo() throws -> (String, String, String) {
        guard let name = detailView.nameTextField.text, setName(name) else { throw ContactError.errorName }
        guard let age = detailView.ageTextField.text, setAge(age) else { throw ContactError.errorAge }
        guard let phone = detailView.phoneNumberTextField.text, setNumber(phone) else { throw ContactError.errorNumber }
        
        return (name.removeBlank, age.removeBlank, phone)
    }
}

extension ContactDetailViewController {
    @objc func edit() {
        guard let text = detailView.phoneNumberTextField.text?.replacingOccurrences(of: "-", with: "") else {
            return
        }

        detailView.phoneNumberTextField.text = text.formmater
    }
}
