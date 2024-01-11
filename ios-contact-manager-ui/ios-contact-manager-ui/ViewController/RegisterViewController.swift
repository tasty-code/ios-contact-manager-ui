
import UIKit

// MARK: - init & deinit
final class RegisterViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    deinit {print("RegisterViewController has been deinit!!")}
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) { 
        dismiss(animated: true)
    }
}

// MARK: - LifeCycle
extension RegisterViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

// MARK: - Regex
extension RegisterViewController {
    func isValidPhoneNumber(_ number: String) -> Bool {
        let phoneNumberRegex = "^(02|0[3-9]{1}[0-9]{1})-?[0-9]{3,4}-?[0-9]{4}$|^(010)-?[0-9]{4}-?[0-9]{4}$"
        let phoneNumberTest = NSPredicate(format: "SELF MATCHES %@", phoneNumberRegex)
        return phoneNumberTest.evaluate(with: number)
    }
}
