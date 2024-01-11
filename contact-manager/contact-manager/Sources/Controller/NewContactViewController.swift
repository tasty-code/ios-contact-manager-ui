import UIKit

final class NewContactViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    private lazy var navigationBar: UINavigationBar = {
        let navigationBar = UINavigationBar()
        let navigationItem = UINavigationItem(title: "새 연락처")
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonTapped))
        navigationItem.leftBarButtonItem = cancelButton
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonTapped))
        navigationItem.rightBarButtonItem = saveButton
        navigationBar.setItems([navigationItem], animated: false)
        
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.backgroundColor = .white
        navigationBarAppearance.shadowColor = nil
        navigationBar.standardAppearance = navigationBarAppearance
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        return navigationBar
    }()
}

extension NewContactViewController {
    private func setupLayout() {
        view.backgroundColor = .white
        setupNavigationBar()
        setupInputForm()
    }
    
    private func setupNavigationBar() {
        view.addSubview(navigationBar)
        NSLayoutConstraint.activate([
            navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navigationBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    private func setupInputForm() {
        
    }
}

extension NewContactViewController {
    @objc private func cancelButtonTapped() {
        
    }
    
    @objc private func saveButtonTapped() {
        
    }
}
