import UIKit

@available(iOS 16.0, *)
final class NewContactViewController: UIViewController {
    
    @IBOutlet private weak var cancelButton: UIBarButtonItem!
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var ageTextField: UITextField!
    @IBOutlet private weak var contactTextField: UITextField!
    private let alertController = UIAlertController()
    
    weak var delegate: DataSendable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func contactTextFieldEditingChanged(_ sender: UITextField) {
        guard let text = sender.text?.replacingOccurrences(of: "-", with: "") else { return }
        sender.text = text.formattingPhoneNumber(divider: "-")
    }
    
    
    @IBAction private func touchUpSaveButton(_ sender: Any) {
        guard let name = checkName(),
              let age = checkAge(),
              let contact = checkContact() else {
            return
        }
        
        delegate?.send(ContactDTO(name: name, age: age, phoneNumber: contact))
        
        self.dismiss(animated: true)
    }
    
    private func checkName() -> String? {
        let regex = /^\S+$/
        if let name = nameTextField.text, let _ = name.wholeMatch(of: regex) {
            return name
        } else {
            alertController
                .configureAlertController(title: "입력된 이름 정보가 잘못되었습니다",
                                          message: nil,
                                          defaultAction: "예",
                                          destructiveAction: nil,
                                          viewController: self)
            return nil
        }
    }
    
    private func checkAge() -> String? {
        let regex = /^[0-9]{1, 3}$/
        if let age = ageTextField.text, let _ = age.wholeMatch(of: regex) {
            return age
        } else {
            alertController
                .configureAlertController(title: "입력된 나이 정보가 잘못되었습니다",
                                          message: nil,
                                          defaultAction: "예",
                                          destructiveAction: nil,
                                          viewController: self)
            return nil
        }
    }
    
    private func checkContact() -> String? {
        let regex = /^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})-?[0-9]{3,4}-?[0-9]{4}$/
        if let contact = contactTextField.text, let _ = contact.wholeMatch(of: regex) {
            return contact
        } else {
            alertController
                .configureAlertController(title: "입력된 연락처 정보가 잘못되었습니다",
                                          message: nil,
                                          defaultAction: "예",
                                          destructiveAction: nil,
                                          viewController: self)
            return nil
        }
    }
    
    @IBAction private func touchUpCancelButton(_ sender: UIBarButtonItem) {
        alertController
            .configureAlertController(title: "정말로 취소하시겠습니까?",
                                      message: nil,
                                      defaultAction: "아니오",
                                      destructiveAction: "예",
                                      viewController: self)
    }
}

