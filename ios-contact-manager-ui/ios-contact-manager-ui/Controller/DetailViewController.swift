
import UIKit

class DetailViewController: UIViewController {
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
    }
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
    }
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        keyboardSetUp()
    }
}

extension DetailViewController: UITextFieldDelegate {
    func keyboardSetUp() {
        nameTextField.keyboardType = .default
        ageTextField.keyboardType = .numberPad
        phoneNumberTextField.keyboardType = .numberPad
    }
}
