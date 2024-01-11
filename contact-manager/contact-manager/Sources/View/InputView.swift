import UIKit

struct InputViewConfiguration {
    let labelText: String
    let keyboardType: UIKeyboardType
}

final class InputView: UIView {
    
    private lazy var label: UILabel = {
        let label = LabelFactory.build(text: "", font: .systemFont(ofSize: 14.0))
        label.widthAnchor.constraint(equalToConstant: 50).isActive = true
        return label
    }()
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 8.0
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.borderStyle = .roundedRect
        return textField
    }()

    private lazy var hStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [label, textField])
        stackView.axis = .horizontal
        stackView.spacing = 30
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    init(config: InputViewConfiguration) {
        super.init(frame: .zero)
        self.label.text = config.labelText
        self.textField.keyboardType = config.keyboardType
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension InputView {
    private func setupLayout() {
        addSubview(hStack)
        NSLayoutConstraint.activate([
            hStack.topAnchor.constraint(equalTo: topAnchor),
            hStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            hStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            hStack.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func textFieldValue() -> String {
        textField.text ?? ""
    }
}
