//
//  ContactManagerTableViewController.swift
//  ContactManagerUI
//
//  Created by Blu on 2023/01/31.
//

import UIKit

final class ContactManagerTableViewController: UITableViewController {
    
    @IBOutlet private weak var contactManagerTableView: UITableView!
    private var contactInfomation = [ContactInformation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureTableView()
        contactInfomation = loadJSON("Dummy.json")
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func loadJSON<T: Decodable>(_ filename: String) -> T {
        let data: Data
        
        guard let filePath = Bundle.main.url(forResource: filename, withExtension: nil) else {
            fatalError("\(filename) not found.")
        }
        
        do {
            data = try Data(contentsOf: filePath)
        } catch {
            fatalError("Could not load \(filename): (error)")
        }
        
        do {
            let jsonDecoder = JSONDecoder()
            return try jsonDecoder.decode(T.self, from: data)
        } catch {
            fatalError("Unable to parse \(filename): (error)")
        }
    }
}

extension ContactManagerTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactInfomation.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(cellClass: UITableViewCell.self, for: indexPath)
        
        cell.configurationUpdateHandler = { cell, state in
            var infoContent = cell.defaultContentConfiguration().updated(for: state)
            infoContent.text = "\(self.contactInfomation[indexPath.row].name)(\(self.contactInfomation[indexPath.row].age))"
            infoContent.secondaryText = self.contactInfomation[indexPath.row].phoneNumber
            
            cell.accessoryType = .disclosureIndicator
            cell.contentConfiguration = infoContent
        }
        return cell
    }
}
