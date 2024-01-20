
import UIKit

protocol ContactListDelegate {
    func reloadContactList()
}

final class DetailViewController: UIViewController {
    var model: ContactManager? = nil
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    var delegate: ContactListDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        keyboardSetup()
        targetingAddHyphen()
    }
    
    func updateContactdata() {
        delegate?.reloadContactList()
    }
}

extension DetailViewController {
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        let yesAction = UIAlertAction(title: "예", style: .destructive) { [weak self] _ in
            self?.dismiss(animated: true)
        }
        let noAction = UIAlertAction(title: "아니오", style: .default)
        
        self.showMessageAlert(message: "정말 취소하시겠습니까?", actionList: [noAction, yesAction])
        }
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        let name = nameTextField.text?.replacingOccurrences(of: " ", with: "") ?? ""
        let age = ageTextField.text ?? ""
        let phoneNumber = phoneNumberTextField.text ?? ""
        
        let isValidList = isInputTextValid(name: name, age: age, phoneNumber: phoneNumber)
        isValidCheck(result: isValidList, personData: [name, age, phoneNumber])
    }
    
    func isInputTextValid(name: String, age: String, phoneNumber: String) -> [String: Bool] {
        let namePattern = "^[a-zA-Z가-힣]*$"
        let agePattern = "^[0-9]{1,3}$"
        let phoneNumberPattern = "^\\d{2,3}-\\d{3,4}-\\d{4}$"
        
        let isNameValid = NSPredicate(format: "SELF MATCHES %@", namePattern).evaluate(with: name)
        let isAgeValid = NSPredicate(format: "SELF MATCHES %@", agePattern).evaluate(with: age)
        let isPhoneNumberValid = NSPredicate(format: "SELF MATCHES %@", phoneNumberPattern).evaluate(with: phoneNumber)
        
        return ["name": isNameValid, "age": isAgeValid, "phoneNumber": isPhoneNumberValid]
    }
    
    func isValidCheck(result: [String: Bool], personData: [String]) {
        let okAction = UIAlertAction(title: "확인", style: .default)
        let personData = Person(name: personData[0], age: Int(personData[1]) ?? 0, phoneNumber: personData[2])
        
        if result["name"] == false {
            self.showMessageAlert(message: "입력한 이름 정보가 잘못되었습니다", actionList: [okAction])
        } else if result["age"] == false {
            self.showMessageAlert(message: "입력한 나이 정보가 잘못되었습니다", actionList: [okAction])
        } else if result["phoneNumber"] == false {
            self.showMessageAlert(message: "입력한 연락처 정보가 잘못되었습니다", actionList: [okAction])
        } else {
            model?.addPerson(person: personData)
            updateContactdata()
            self.dismiss(animated: true)
        }
    }
}


extension DetailViewController: UITextFieldDelegate {
    private func keyboardSetup() {
        nameTextField.keyboardType = .default
        ageTextField.keyboardType = .numberPad
        phoneNumberTextField.keyboardType = .numberPad
    }
    
    private func targetingAddHyphen() {
        phoneNumberTextField.addTarget(self, action: #selector(editingPhoneNumberText(_:)), for: .editingChanged)
    }
    
    @objc
    private func editingPhoneNumberText(_ textField: UITextField) {
        textField.text = textField.text?.addPhoneNumberHyphen()
    }
}
