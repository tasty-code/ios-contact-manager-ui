
import UIKit

// MARK: - init & deinit
final class RegisterViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    var phoneBook: PhoneBook?
    
    var wrongAgeInput = false
    var wrongNameInput = false
    var wrongPhoneNumInput = false
        
    deinit { print("RegisterViewController has been deinit!!") }
    
    @IBAction private func validateNameTextField(_ sender: UITextField) {
        let minCount = 2
        let maxCount = 12
        
        if validateCountCondition(input: sender.text ?? "", condition: (minCount, maxCount)) && isValidName(sender.text ?? "") {
            changeTextBorderColor(textField: nameTextField, color: UIColor.systemBlue.cgColor)
            wrongNameInput = false
        } else {
            changeTextBorderColor(textField: nameTextField, color: UIColor.systemPink.cgColor)
            wrongNameInput = true
        }
    }
    
    @IBAction private func validateAgeTextField(_ sender: UITextField) {
        
        let minAge = 1
        let maxAge = 99
        
        if validateCountCondition(input: sender.text ?? "", condition: (minAge, maxAge)) {
            changeTextBorderColor(textField: ageTextField, color: UIColor.systemBlue.cgColor)
            wrongAgeInput = true
        } else {
            changeTextBorderColor(textField: ageTextField, color: UIColor.systemPink.cgColor)
            wrongAgeInput = false
        }
    }
    
    @IBAction private func phoneNumberTextFieldChanged(_ sender: UITextField) {
        print("연락처 입력 변화")
        
        let convertDigit = sender.text!.replacingOccurrences(of: #"\D"#, with: "", options: .regularExpression)
        
        let count = convertDigit.count
        switch count {
        case 0:
            phoneNumberTextField.text = convertDigit
        case 1...3:
            phoneNumberTextField.text = convertDigit
        case 4...7:
            phoneNumberTextField.text = convertDigit.prefix(3) + "-" + convertDigit.suffix(convertDigit.count-3)
            
            wrongPhoneNumInput = true
        case 8...11:
            let startIndex = convertDigit.index(convertDigit.startIndex, offsetBy: 3)
            let endingIndex = convertDigit.index(convertDigit.startIndex, offsetBy: count-5)
            let middleNumber = convertDigit[startIndex...endingIndex]
            phoneNumberTextField.text = convertDigit.prefix(3) + "-" + middleNumber + "-" + convertDigit.suffix(4)
            wrongPhoneNumInput = false
        default:
            wrongPhoneNumInput = true
        }
    }
    
    @IBAction private func saveButtonTapped(_ sender: UIBarButtonItem) {
        validateTextField()
        print("연락처 저장됨")
        phoneBook?.categorizedContactInfo.append(User(
                                                userID: UUID(),
                                                name: nameTextField.text ?? "",
                                                phoneNumber: phoneNumberTextField.text ?? "",
                                                age: Int(ageTextField.text ?? "") ?? 0)
        )
    }
    
    
    private func validateTextField() {


        if !wrongAgeInput {
            presentAlert(title: "입력에러", message: "나이 입력창을 확인해주세요", confirmTitle: "확인")
            return
        }
        
        if !wrongNameInput {
            presentAlert(title: "입력에러", message: "이름 입력창을 확인해주세요", confirmTitle: "확인")
            return
        }
        
        if !wrongPhoneNumInput {
            presentAlert(title: "입력에러", message: "번호 입력창을 확인해주세요", confirmTitle: "확인")
            return
        }
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
    
    func isValidName(_ name: String) -> Bool {
        let koreanNameRegex = "^[가-힣ㄱ-ㅎㅏ-ㅣ]"
        return true
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
