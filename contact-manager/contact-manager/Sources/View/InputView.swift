import UIKit

struct InputViewConfiguration {
    let labelText: String
    let keyboardType: UIKeyboardType
}

final class InputView: UIView {
    var textFieldValue: String {
        get {
            textField.text ?? ""
        }
        set {
            textField.text = newValue
        }
    }
    
    private let label: UILabel = {
        let label = LabelFactory.build(text: "", font: .systemFont(ofSize: 14.0))
        label.widthAnchor.constraint(equalToConstant: 50).isActive = true
        return label
    }()
    
    private let textField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private lazy var hStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [label, textField])
        stackView.axis = .horizontal
        stackView.spacing = 10
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
}
