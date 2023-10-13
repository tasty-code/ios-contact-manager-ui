import UIKit

@available(iOS 16.0, *)
class NewContactViewController: UIViewController {
    
    @IBOutlet private weak var cancelButton: UIBarButtonItem!
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var ageTextField: UITextField!
    @IBOutlet private weak var contactTextField: UITextField!
    private let alertController = UIAlertController()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction private func touchUpSaveButton(_ sender: Any) {
        checkName()
        checkAge()
        checkContact()
    }
    
    private func checkName() {
        let regex = /^\S+$/
        if let name = nameTextField.text, let match = name.wholeMatch(of: regex) {
            print(match.output)
        } else {
            alertController
                .configureAlertController(title: "입력된 이름 정보가 잘못되었습니다",
                                          message: nil,
                                          defaultAction: "예",
                                          destructiveAction: nil,
                                          viewController: self)
        }
    }
    
    private func checkAge() {
        let regex = /^[0-9]{1, 3}$/
        if let age = ageTextField.text, let match = age.wholeMatch(of: regex) {
            print(match.output)
        } else {
            alertController
                .configureAlertController(title: "입력된 나이 정보가 잘못되었습니다",
                                          message: nil,
                                          defaultAction: "예",
                                          destructiveAction: nil,
                                          viewController: self)
        }
    }
    
    private func checkContact() {
        let regex = /^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})-?[0-9]{3,4}-?[0-9]{4}$/
        if let contact = contactTextField.text, let match = contact.wholeMatch(of: regex) {
            // 가능하면 match.output으로 받을 수 있도록 regex 수정하기
            print(match.output.0)
        } else {
            alertController
                .configureAlertController(title: "입력된 연락처 정보가 잘못되었습니다",
                                          message: nil,
                                          defaultAction: "예",
                                          destructiveAction: nil,
                                          viewController: self)
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
