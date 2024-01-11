
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
