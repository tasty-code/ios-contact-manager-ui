//
//  ViewController.swift
//  ios-contact-manager-ui
//
//  Created by 미르, 루피 on 1/2/24.
//

import UIKit

class ViewController: UIViewController {
    let table = UITableView()
    var contacts: [Contact] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        table.dataSource = self
        table.register(CustomCell.self, forCellReuseIdentifier: "cell")
        parse()
    }
    
    func layout() {
        view.addSubview(table)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        table.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        table.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        table.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
    
    func parse() {
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
        
        return cell
    }
}


