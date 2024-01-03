
import UIKit

// MARK: - PhoneBookViewController Init & Deinit
final class PhoneBookViewController: UIViewController {
    
    let tableView = UITableView()
    
    deinit {print("PhoneBookViewController has been deinit!!")}
}

// MARK: - LifeCycle
extension PhoneBookViewController {
    override func viewDidLoad() {
        setupTableView()
        setupUI()
    }
}

//MARK: - Setup TableView
private extension PhoneBookViewController {
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self

        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.reuseID)
        tableView.tableFooterView = UIView()
    }
}

//MARK: - SetupUI
private extension PhoneBookViewController {
    func setupUI() {
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}


// MARK: - TableView Delegate
extension PhoneBookViewController: UITableViewDelegate {
    //Action
}

extension PhoneBookViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10 //Dummy
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.reuseID, for: indexPath) as! TableViewCell
        return cell
    }
}


