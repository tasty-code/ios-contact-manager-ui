//
//  ContactCreationViewController.swift
//  ContactManager
//
//  Created by Wonji Ha on 2023/10/11.
//

import UIKit

class ContactCreationViewController: UIViewController {

    let nameStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 10
        return stackView
    }()
    
    let ageStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 10
        return stackView
    }()
    
    let phoneStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 5
        return stackView
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 15
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        self.view.backgroundColor = .systemBackground
        setNavigationBar()
        contactView()
    }
    
    func setNavigationBar() {
        let navbar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
        navbar.backgroundColor = .clear
        navbar.barTintColor = .systemBackground
        
        navbar.setBackgroundImage(UIImage(), for: .default)
        navbar.shadowImage = UIImage()
        navbar.layer.shadowColor = UIColor.clear.cgColor
        navbar.isTranslucent = true
        
        let navItem = UINavigationItem(title: "새 연락처")
        
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(didTapCancelButton))
        let saveButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(didTapSaveButton))
        
        navItem.leftBarButtonItem = cancelButton
        navItem.rightBarButtonItem = saveButton
        navbar.setItems([navItem], animated: false)
        self.view.addSubview(navbar)
    }
    
    @objc func didTapCancelButton(_ sender: UINavigationItem) {
        dismiss(animated: true)
    }
    @objc func didTapSaveButton(_ sender: UINavigationItem) {
        print("save tapped")
    }
    
    func contactView() {
        let nameLabel = UILabel()
        let nameField = UITextField()
        let ageLabel = UILabel()
        let ageField = UITextField()
        let phoneNumberLabel = UILabel()
        let phoneNumberField = UITextField()

        nameLabel.text = "이름"
        nameField.borderStyle = .roundedRect
        nameField.widthAnchor.constraint(equalToConstant: 320).isActive = true
        
        ageLabel.text = "나이"
        ageField.borderStyle = .roundedRect
        ageField.keyboardType = .numberPad
        ageField.widthAnchor.constraint(equalToConstant: 320).isActive = true

        phoneNumberLabel.text = "연락처"
        phoneNumberField.borderStyle = .roundedRect
        phoneNumberField.keyboardType = .phonePad
        phoneNumberField.widthAnchor.constraint(equalToConstant: 320).isActive = true

        let nameStack = [nameLabel, nameField]
        nameStack.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.nameStackView.addArrangedSubview($0)
        }


        let ageStack = [ageLabel, ageField]
        ageStack.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.ageStackView.addArrangedSubview($0)
        }
        
        let phoneStack = [phoneNumberLabel, phoneNumberField]
        phoneStack.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.phoneStackView.addArrangedSubview($0)
        }
        
        let stacksView = [nameStackView, ageStackView, phoneStackView]
        for stack in stacksView {
            self.stackView.addArrangedSubview(stack)
        }
        
        view.addSubview(stackView)
        
        stackView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100).isActive = true
        stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
    }
}
