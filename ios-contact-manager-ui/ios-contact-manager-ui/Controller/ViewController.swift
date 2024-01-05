//
//  ViewController.swift
//  ios-contact-manager-ui
//
//  Created by 미르, 루피 on 1/2/24.
//

import UIKit

class ViewController: UIViewController {
    private let table = UITableView()
    private var contacts: [Contact] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        parse()
        configure()
    }
    
    private func layout() {
        view.addSubview(table)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        table.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        table.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        table.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
    
    private func configure() {
        table.dataSource = self
        table.delegate = self
        table.register(CustomCell.self, forCellReuseIdentifier: "cell")
    }
    
    private func parse() {
        guard let asset = NSDataAsset(name: "data") else { return }
        
        do {
            contacts = try JSONDecoder().decode([Contact].self, from: asset.data)
        } catch {
            print(error.localizedDescription)
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell" , for: indexPath)
        let item = contacts[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        
        content.text = item.nameAge
        content.secondaryText = item.phoneNumber
        
        cell.contentConfiguration = content
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


