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
    public weak var delegate: ContactCreationVCDelegate?
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 15
        return stackView
    }()
    
    private let nameStack = CreationStackView(frame: CGRect(), type: .name)
    private let ageStack = CreationStackView(frame: CGRect(), type: .age)
    private let phoneNumStack = CreationStackView(frame: CGRect(), type: .phoneNum)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        
        nameStack.field.delegate = self
        ageStack.field.delegate = self
        phoneNumStack.field.delegate = self
        
        addSubViews()
        addConstraint()
        addNavigationBar()
    }
    
    private func addSubViews() {
        ageStack.field.borderStyle = .roundedRect
        ageStack.field.keyboardType = .numberPad
        
        phoneNumStack.field.borderStyle = .roundedRect
        phoneNumStack.field.keyboardType = .phonePad
        
        stackView.addArrangedSubviews(nameStack, ageStack, phoneNumStack)
        view.addSubview(stackView)
    }
    
    private func addConstraint() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 100),
            stackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
        ])
    }
    
    private func addNavigationBar() {
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
        
        guard let age = ageStack.field.text, let ageToInt = Int(age), let phoneNum = phoneNumStack.field.text, let name = nameStack.field.text else {
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
}

extension ContactCreationViewController: UITextFieldDelegate {
    private func hideKeyboard() {
        self.view.endEditing(true)
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
        case ageStack.field:
            return isDecimalDigit(string)
        case phoneNumStack.field:
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
