
import UIKit

// MARK: - PhoneBookViewController Init & Deinit
final class PhoneBookViewController: UIViewController {
    
    let tableView = UITableView()
    var phoneBook: PhoneBook? = nil
    
    deinit {print("PhoneBookViewController has been deinit!!")}
}

// MARK: - LifeCycle
extension PhoneBookViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupUI()
    }
}

// MARK: - Setup TableView
private extension PhoneBookViewController {
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        let nib = UINib(nibName: "TableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: TableViewCell.reuseID)
//        tableView.backgroundColor = .lightGray
        setupTableHeaderView()
    }
    
    func setupTableHeaderView() {
        let header = HeaderView(frame: .zero)
        var size = header.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        size.width = UIScreen.main.bounds.width
        header.frame.size = size
        tableView.tableHeaderView = header
    }

}

// MARK: - SetupUI
private extension PhoneBookViewController {
    func setupUI() {
        setupConstraints()
    }
    
    func setupConstraints() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}


// MARK: - TableView Delegate
extension PhoneBookViewController: UITableViewDelegate {
    
}

extension PhoneBookViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        let hangulChosungCount = 14
        return hangulChosungCount
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let stringArray = ["가", "나", "다", "라", "마", "바", "사", "아", "자", "차", "카", "타", "파", "하"]
        return stringArray[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return phoneBook?.categorizedBook[section]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.reuseID, for: indexPath) as! TableViewCell
        
        let user = phoneBook?.categorizedBook[indexPath.section]
        let userName = user?[indexPath.row].name
        let userage = user?[indexPath.row].age
        let userNumber = user?[indexPath.row].phoneNumber
        
        cell.nameLabel.text = "\(userName)(\(userage)))"
        cell.phoneNumberLabel.text = userNumber
        
        return cell
    }
}


