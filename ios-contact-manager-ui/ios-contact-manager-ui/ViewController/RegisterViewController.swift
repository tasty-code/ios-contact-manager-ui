
import UIKit

// MARK: - init & deinit
final class RegisterViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    var phoneBook: PhoneBook?
    
    var isRightAgeInput = false
    var isRightNameInput = false
    var isRightPhoneNumInput = false
        
    deinit { print("RegisterViewController has been deinit!!") }
    
    @IBAction private func validateNameTextField(_ sender: UITextField) {
        let minCount = 2
        let maxCount = 12
        
        if validateCountCondition(input: sender.text ?? "", condition: (minCount, maxCount)){
            changeTextBorderColor(textField: nameTextField, color: UIColor.systemBlue.cgColor)
            isRightNameInput = true
        } else {
            changeTextBorderColor(textField: nameTextField, color: UIColor.systemPink.cgColor)
            isRightNameInput = false
        }
    }
    
    @IBAction private func validateAgeTextField(_ sender: UITextField) {
        let minCount = 1
        let maxCount = 3
        
        if validateCountCondition(input: sender.text ?? "", condition: (minCount, maxCount)) {
            changeTextBorderColor(textField: ageTextField, color: UIColor.systemBlue.cgColor)
            isRightAgeInput = true
        } else {
            changeTextBorderColor(textField: ageTextField, color: UIColor.systemPink.cgColor)
            isRightAgeInput = false
        }
    }
    
    @IBAction private func phoneNumberTextFieldChanged(_ sender: UITextField) {
        print("연락처 입력 변화")
        
        let convertDigit = sender.text!.replacingOccurrences(of: #"\D"#, with: "", options: .regularExpression)
        
        switch convertDigit.count {
        case 0...3:
            phoneNumberTextField.text = convertDigit
        case 4...7:
            phoneNumberTextField.text = convertDigit.prefix(3) + "-" + convertDigit.suffix(convertDigit.count-3)
            isRightPhoneNumInput = true
        case 4...11:
            let startIndex = convertDigit.index(convertDigit.startIndex, offsetBy: 3)
            let endingIndex = convertDigit.index(convertDigit.startIndex, offsetBy: convertDigit.count-5)
            let middleNumber = convertDigit[startIndex...endingIndex]
            phoneNumberTextField.text = convertDigit.prefix(3) + "-" + middleNumber + "-" + convertDigit.suffix(4)
            isRightPhoneNumInput = true
        default:
            isRightPhoneNumInput = false
        }
    }
    
    @IBAction private func saveButtonTapped(_ sender: UIBarButtonItem) {
        guard validateTextField() == true else { return }
        print("연락처 저장됨")
        phoneBook?.categorizedContactInfo.append(User(
                                                userID: UUID(),
                                                name: nameTextField.text ?? "",
                                                phoneNumber: phoneNumberTextField.text ?? "",
                                                age: Int(ageTextField.text ?? "") ?? 0)
        )
        self.dismiss(animated: true)
    }
    
    
    private func validateTextField() -> Bool {
        
        if !isRightNameInput {
            presentAlert(title: "입력에러", message: "이름 입력창을 확인해주세요", confirmTitle: "확인")
            return false
        }

        if !isRightAgeInput {
            presentAlert(title: "입력에러", message: "나이 입력창을 확인해주세요", confirmTitle: "확인")
            return false
        }
        
        if !isRightPhoneNumInput {
            presentAlert(title: "입력에러", message: "번호 입력창을 확인해주세요", confirmTitle: "확인")
            return false
        }
        return true
    }
    
    
    @IBAction private func cancelButtonTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
}

// MARK: - LifeCycle
extension RegisterViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

// MARK: - Extension
extension RegisterViewController {
    func isValidPhoneNumber(_ number: String) -> Bool {
        let phoneNumberRegex = "^(02|0[3-9]{1}[0-9]{1})-?[0-9]{3,4}-?[0-9]{4}$|^(010)-?[0-9]{4}-?[0-9]{4}$"
        let phoneNumberTest = NSPredicate(format: "SELF MATCHES %@", phoneNumberRegex)
        return phoneNumberTest.evaluate(with: number)
    }
}

private extension RegisterViewController {
    func validateCountCondition(input: String, condition: (Int,Int)) -> Bool {
        guard input.count >= condition.0 else { print("2글자 이상의 이름을 입력해 주세요."); return false }
        guard input.count < condition.1 else { print("1~99의 숫자를 입력해 주세요."); return false }
        return true
    }
    
    
    func changeTextBorderColor(textField: UITextField, color: CGColor) {
        textField.layer.borderColor = color
        textField.layer.borderWidth = 2
    }
}
