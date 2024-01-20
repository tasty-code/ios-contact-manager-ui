import UIKit

final class DetailContactView: UIView {
    
    private lazy var nameLabel: UILabel = setupLabel(text: CustomTextFieldString.nameText.description)
    private lazy var ageLabel: UILabel = setupLabel(text: CustomTextFieldString.ageText.description)
    private lazy var phoneNumberLabel: UILabel = setupLabel(text: CustomTextFieldString.phoneNumberText.description)
    
    lazy var nameTextField: UITextField = setupTextField()
    lazy var ageTextField: UITextField = setupTextField()
    lazy var phoneNumberTextField: UITextField = setupTextField()
    
    lazy var nameTextFieldView: UIStackView = setupTextFieldView(label: nameLabel, textField: nameTextField)
    lazy var ageTextFieldView: UIStackView = setupTextFieldView(label: ageLabel, textField: ageTextField)
    lazy var phoneNumberTextFieldView: UIStackView = setupTextFieldView(label: phoneNumberLabel, textField: phoneNumberTextField)
    
    private lazy var stackView: UIStackView = setupStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupSubView()
        setupKeyboard()
        setupCustomAutoresizing()
        setupConstraints()
        setupPhoneNumerAddTarget(phoneNumberTextField)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError(CustomViewControllerString.fatalErrorText.description)
    }
}
// MARK: Methed
extension DetailContactView {
    
    private func setupLabel(text: String) -> UILabel {
        let label: UILabel = UILabel()
        label.text = text
        label.textAlignment = .center
        return label
    }
    
    private func setupTextField() -> UITextField {
        let textField: UITextField = UITextField()
        textField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 6.0, height: 0.0))
        textField.leftViewMode = .always
        textField.textAlignment = .left
        textField.autocapitalizationType = .none
        textField.spellCheckingType = .no
        textField.clearsOnBeginEditing = false
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.cornerRadius = 3
        textField.clipsToBounds = true
        
        return textField
    }
    
    private func setupPhoneNumerAddTarget(_ textField: UITextField) {
        textField.addTarget(self, action: #selector(phoneNumberEditingChanged(_:)), for: .editingChanged)
    }
    
    private func setupTextFieldView(label: UILabel, textField: UITextField) -> UIStackView {
        let stack: UIStackView = UIStackView(arrangedSubviews: [label, textField])
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        stack.alignment = .fill
        stack.spacing = 14
        stack.addSubview(label)
        stack.addSubview(textField)
        return stack
    }
    
    private func setupStackView() -> UIStackView {
        let stack: UIStackView = UIStackView(arrangedSubviews: [nameTextFieldView, ageTextFieldView, phoneNumberTextFieldView])
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.alignment = .fill
        stack.spacing = 14
        stack.addSubview(nameTextFieldView)
        stack.addSubview(ageTextFieldView)
        stack.addSubview(phoneNumberTextFieldView)
        return stack
    }
    
    private func setupUI() {
        self.backgroundColor = .white
    }
    
    private func setupKeyboard() {
        nameTextField.keyboardType = .default
        ageTextField.keyboardType = .numberPad
        phoneNumberTextField.keyboardType = .phonePad
    }
    
    private func setupSubView() {
        addSubview(stackView)
    }
    
    private func setupCustomAutoresizing() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        nameTextFieldView.translatesAutoresizingMaskIntoConstraints = false
        ageLabel.translatesAutoresizingMaskIntoConstraints = false
        ageTextField.translatesAutoresizingMaskIntoConstraints = false
        ageTextFieldView.translatesAutoresizingMaskIntoConstraints = false
        phoneNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        phoneNumberTextField.translatesAutoresizingMaskIntoConstraints = false
        phoneNumberTextFieldView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupConstraints() {
        let widthSize: CGFloat = 60
        let heightSize: CGFloat = 34
        let sidePaddingSize: CGFloat = 14
        let topPaddingSize: CGFloat = 20
        
        NSLayoutConstraint.activate([
            nameLabel.widthAnchor.constraint(equalToConstant: widthSize),
            ageLabel.widthAnchor.constraint(equalToConstant: widthSize),
            phoneNumberLabel.widthAnchor.constraint(equalToConstant: widthSize),
                
            nameTextFieldView.heightAnchor.constraint(equalToConstant: heightSize),
            ageTextFieldView.heightAnchor.constraint(equalToConstant: heightSize),
            phoneNumberTextFieldView.heightAnchor.constraint(equalToConstant: heightSize),
                
            stackView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: sidePaddingSize),
            stackView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -sidePaddingSize),
            stackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: topPaddingSize)
        ])
    }
    
    @objc
    private func phoneNumberEditingChanged(_ textField: UITextField) {
        textField.text = textField.text?.addPhoneNumberHyphen()
    }
}
