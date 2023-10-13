//
//  ContactCreationViewController.swift
//  ContactManager
//
//  Created by Wonji Ha on 2023/10/11.
//

import UIKit

protocol ContactCreationVCDelegate: AnyObject {
    func addContact(_ contact: ContactInfo)
}

class ContactCreationViewController: UIViewController {
    weak var delegate: ContactCreationVCDelegate?
    
    let nameLabel = UILabel()
    let nameField = UITextField()
    let ageLabel = UILabel()
    let ageField = UITextField()
    let phoneNumberLabel = UILabel()
    let phoneNumberField = UITextField()
    
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
        self.nameField.delegate = self
        self.ageField.delegate = self
        self.phoneNumberField.delegate = self
        setup()
    }
    
    private func setup() {
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
        hideKeyboard()
        let alert = UIAlertController(title: nil, message: "정말로 취소하시겠습니까?", preferredStyle: .alert)
        
        let cancel = UIAlertAction(title: "아니오", style: .cancel, handler: nil)
        let confirm = UIAlertAction(title: "예", style: .destructive, handler: { [weak self] _ in
            self?.dismiss(animated: true)
        })
        
        alert.addAction(cancel)
        alert.addAction(confirm)
        present(alert, animated: true, completion: nil)
        
    }
    
    @objc func didTapSaveButton(_ sender: UINavigationItem) {
        hideKeyboard()
      
        guard let age = ageField.text, let ageToInt = Int(age), let phoneNum = phoneNumberField.text, let name = nameField.text else {
            presentAlert(message: "정보를 입력해주세요")
            return
        }
        
        let labels: [(String, ValidateType)] = [(age, .age),(name, .name),(phoneNum, .phoneNum)]
        
        do {
           try labels.forEach { text, type in
                try checkValidate(text: text, type: type)
            }
        } catch let error as InvalidError {
            presentAlert(message: error.description)
            return
        } catch {
            presentAlert(message: "잘못된 입력값입니다")
            return
        }
        
        let newContact = ContactInfo(name: name, age: ageToInt, phoneNum: phoneNum)
        self.delegate?.addContact(newContact)
        dismiss(animated: true)
    }
    
    private func contactView() {
        
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

extension ContactCreationViewController: UITextFieldDelegate {
    private func hideKeyboard() {
        self.view.endEditing(true)
        print(nameField.text ?? "")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string == " " {
            return false
        }
        
        switch textField {
        case self.ageField:
            return isDecimalDigit(string)
        case self.phoneNumberField:
            guard isDecimalDigit(string) else { return false }
            
            guard let text = textField.text else {
                return true
            }
            guard string != "" else {
                textField.text = removeSuffix(text)
                return false
            }
            let newVal = formatContactNumber(text)
            textField.text = newVal
            return true
        default:
            break
        }
        
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension ContactCreationViewController {
    func checkValidate(text: String, type: ValidateType) throws -> Void {
        guard !text.isEmpty else {
            throw InvalidError.invalidInput(type)
        }
        
        var isValidate: Bool = true
        switch type {
        case .age:
            isValidate = !text.contains("-") && text.count < 4
            break
        case .phoneNum:
            isValidate = text.components(separatedBy: "-").count == 3 && text.count > 8
            break
        default:
            break
        }
        
        guard isValidate else {
            throw InvalidError.invalidInput(type)
        }
    }
    
    func presentAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        
        let confirm = UIAlertAction(title: "확인", style: .cancel, handler: nil)
        alert.addAction(confirm)
        present(alert, animated: true, completion: nil)
    }
}

extension ContactCreationViewController {
    func isDecimalDigit(_ char: String) -> Bool {
        let characters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: char)
        return characters.isSuperset(of: characterSet)
    }
    func formatContactNumber(_ text: String) -> String {
        let removeAllHyphenPatterns = [
            "^02-\\d{4}-\\d{4}$",
            "^0[013456789]\\d-\\d{4}-\\d{4}$"].joined(separator: "|")
        
        if matches(text, with: removeAllHyphenPatterns) {
            return text.replacingOccurrences(of: "-", with: "")
        }
        
        let addHyphenPatterns = [
            "^02$",
            "^0[013456789]\\d$",
            "^02-\\d{3}$",
            "^0[013456789]\\d-\\d{3}$"
        ].joined(separator: "|")
        
        if matches(text, with: addHyphenPatterns) {
            return text + "-"
        }
        
        let swapHyphenPatterns = [
            "^02-\\d{3}-\\d{4}$",
            "^0[013456789]\\d-\\d{3}-\\d{4}$"
        ].joined(separator: "|")
        
        if matches(text, with: swapHyphenPatterns), let targetIdx = text.lastIndex(of: "-") {
            let stored = text.index(after: targetIdx)
            return text.replacingCharacters(in: targetIdx...stored, with: String(text[stored]) + "-")
        }
        
        return text
    }

    func matches(_ string: String, with pattern: String) -> Bool {
        guard let _ = string.range(of: pattern, options: .regularExpression) else {
            return false
        }
        return true
    }
    
    func removeSuffix(_ string: String) -> String {
        var copy = string
        if copy.hasSuffix("-") {
            copy.removeLast()
        }
        copy.removeLast()
        return String(copy)
    }
}
