
import UIKit

// MARK: - init & deinit
final class RegisterViewController: UIViewController {
    var wrongAgeInput = false
    var wrongNameInput = false
    var wrongPhoneNumInput = false
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    @IBOutlet weak var tempErrorLabel: UILabel!
    @IBOutlet weak var tempAgeErrorLabel: UILabel!
    @IBOutlet weak var tempPhoneNumberErrorLabel: UILabel!
    
    deinit { print("RegisterViewController has been deinit!!") }

    @IBAction private func validateNameTextField(_ sender: UITextField) {
        let userInput = nameTextField.text ?? " "
        let minCount = 2
        let maxCount = 12
        if validateMaximumNameCondition(input: userInput, condition: maxCount) &&
            validateMinimumNameCondition(input: userInput, condition: minCount) {
            tempErrorLabel.text = ""
            changeTextBorderColor(textField: nameTextField, color: UIColor.systemBlue.cgColor)
            wrongNameInput = false
        } else {
            changeTextBorderColor(textField: nameTextField, color: UIColor.systemPink.cgColor)
            wrongNameInput = true
            }
    }

    
    @IBAction private func validateAgeTextField(_ sender: UITextField) {
        print("나이 입력 변화")
        let userInput = Int(ageTextField.text ?? String()) ?? Int()
        print(userInput)
        let minAge = 1
        let maxAge = 99
        if validateMaximumAgeCondition(input: userInput, condition: maxAge) && 
            validateMinimumAgeCondition(input: userInput, condition: minAge) {
            tempAgeErrorLabel.text = ""
            changeTextBorderColor(textField: ageTextField, color: UIColor.systemBlue.cgColor)
            wrongAgeInput = false
        } else {
            changeTextBorderColor(textField: ageTextField, color: UIColor.systemPink.cgColor)
            wrongAgeInput = true
        }
    }
    
    @IBAction private func phoneNumberTextFieldChanged(_ sender: UITextField) {
        print("연락처 입력 변화")
        
        let convertDigit = phoneNumberTextField.text!.replacingOccurrences(of: #"\D"#, with: "", options: .regularExpression)
        
        let count = convertDigit.count
        switch count {
        case 0:
            tempPhoneNumberErrorLabel.text = "휴대폰 번호를 입력해 주세요."
            phoneNumberTextField.text = convertDigit
        case 1...3:
            phoneNumberTextField.text = convertDigit
        case 4...7:
            phoneNumberTextField.text = convertDigit.prefix(3) + "-" + convertDigit.suffix(convertDigit.count-3)
            tempPhoneNumberErrorLabel.text = "올바르지 않은 휴대폰 번호입니다."
            wrongPhoneNumInput = true
        case 8...11:
            let startIndex = convertDigit.index(convertDigit.startIndex, offsetBy: 3)
            let endingIndex = convertDigit.index(convertDigit.startIndex, offsetBy: count-5)
            let middleNumber = convertDigit[startIndex...endingIndex]
            phoneNumberTextField.text = convertDigit.prefix(3) + "-" + middleNumber + "-" + convertDigit.suffix(4)
            tempPhoneNumberErrorLabel.text = "올바른 휴대폰 번호입니다."
            wrongPhoneNumInput = false
            
        default:
            wrongPhoneNumInput = true
            tempPhoneNumberErrorLabel.text = "올바르지 않은 휴대폰 번호입니다."
            
        }
    }
    
    @IBAction private func saveButtonTapped(_ sender: UIBarButtonItem) {
        if wrongAgeInput == false &&
            wrongNameInput == false &&
            wrongPhoneNumInput == false {
            print("연락처 저장됨")
            dismiss(animated: true)
        } else {
            print(wrongNameInput,wrongAgeInput,wrongPhoneNumInput)
            print("Alert")
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
        let koreanNameRegex =
        "^[가-힣ㄱ-ㅎㅏ-ㅣ]"
        
        return true
    }
}

private extension RegisterViewController {
    func validateMinimumNameCondition(input: String, condition: Int) -> Bool {
        if input.count >= condition {
            return true
        } else {
            tempErrorLabel.text = "2글자 이상의 이름을 입력해 주세요."
            return false
        }
    }
    
    func validateMaximumNameCondition(input: String, condition: Int) -> Bool {
        if input.count < condition {
            return true
        } else {
            tempErrorLabel.text = "12글자 이하의 이름을 입력해 주세요."
            return false
        }
    }
    
    func validateMinimumAgeCondition(input: Int, condition: Int) -> Bool {
        if input >= condition {
            return true
        } else {
            tempAgeErrorLabel.text = "1~99의 숫자를 입력해 주세요."
            return false
        }
    }
    
    func validateMaximumAgeCondition(input: Int, condition: Int) -> Bool {
        if input < condition {
            return true
        } else {
            tempAgeErrorLabel.text = "1~99의 숫자를 입력해 주세요."
            return false
        }
    }
    
    func changeTextBorderColor(textField: UITextField, color: CGColor) {
        textField.layer.borderColor = color
        textField.layer.borderWidth = 2
    }
}
