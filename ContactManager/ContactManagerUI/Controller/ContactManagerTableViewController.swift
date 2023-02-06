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
        assignLoadJSONData()
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func loadJSON<T: Decodable>(_ filename: String) throws -> T {
        let data: Data
        
        guard let filePath = Bundle.main.url(forResource: filename, withExtension: nil) else {
            print("\(filename) not found.")
            throw Errors.notFoundJsonFile
        }
        
        do {
            data = try Data(contentsOf: filePath)
        } catch {
            print("Could not load \(filename): (error)")
            throw Errors.notLoadData
        }
        
        do {
            let jsonDecoder = JSONDecoder()
            return try jsonDecoder.decode(T.self, from: data)
        } catch {
            print("Unable to parse \(filename): (error)")
            throw Errors.unableToParse
        }
    }

    private func assignLoadJSONData() {
        guard let parsedInformation: [ContactInformation] = try? loadJSON("Dummy.json") else { return }
        contactInfomation = parsedInformation
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
