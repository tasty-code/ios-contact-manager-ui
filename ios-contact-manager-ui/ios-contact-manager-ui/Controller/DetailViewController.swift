
import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    let model = ContactManager.shared
    var delegate: ContactListDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        keyboardSetUp()
        targetingAddHyphen()
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        self.sureCancelAlert(message: "정말 취소하시겠습니까?") { [weak self] _ in
            self?.dismiss(animated: true) //okAction
        }
    }
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        let name = nameTextField.text ?? ""
        let age = ageTextField.text ?? ""
        let phoneNumber = phoneNumberTextField.text ?? ""
        
        let namePattern = "^[a-zA-Z가-힣]*$"
        let agePattern = "^[0-9]{1,3}$"
        let phoneNumberPattern = "^\\d{2,3}-\\d{3,4}-\\d{4}$"
        
        let isNameValid = NSPredicate(format: "SELF MATCHES %@", namePattern).evaluate(with: name)
        let isAgeValid = NSPredicate(format: "SELF MATCHES %@", agePattern).evaluate(with: age)
        let isPhoneNumberValid = NSPredicate(format: "SELF MATCHES %@", phoneNumberPattern).evaluate(with: phoneNumber)
        
        switch true {
        case !isNameValid:
            self.showMessageAlert(message: "입력한 이름 정보가 잘못되었습니다")
        case !isAgeValid:
            self.showMessageAlert(message: "입력한 나이 정보가 잘못되었습니다")
        case !isPhoneNumberValid:
            self.showMessageAlert(message: "입력한 연락처 정보가 잘못되었습니다")
        default:
            let personData = Person(name: name, age: Int(age) ?? 0, phoneNumber: phoneNumber)
            model.addPerson(person: personData)
            delegate?.reloadContacts()
            
            self.dismiss(animated: true)
        }
    }
}

extension DetailViewController: UITextFieldDelegate {
    func keyboardSetUp() {
        nameTextField.keyboardType = .default
        ageTextField.keyboardType = .numberPad
        phoneNumberTextField.keyboardType = .numberPad
    }
    
    func targetingAddHyphen() {
        phoneNumberTextField.addTarget(self, action: #selector(editingPhoneNumberText(_:)), for: .editingChanged)
    }
    
    @objc func editingPhoneNumberText(_ textField: UITextField) {
        textField.text = textField.text?.addPhoneNumberHyphen()
    }
}
