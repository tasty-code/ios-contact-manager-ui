//
//  ViewController.swift
//  ContactManagerUI
//
//  Created by DONGWOOK SEO on 2023/01/30.
//

import UIKit

final class ViewController: UIViewController {
    
    private let dummyContactList = Person.dummyData

    @IBOutlet weak private var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
    }
    
    private func setDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dummyContactList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "ContactTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        cell.textLabel?.text = dummyContactList[indexPath.row].name + "(\(dummyContactList[indexPath.row].age))"
        cell.detailTextLabel?.text = dummyContactList[indexPath.row].phoneNum
        
        return cell
    }
}
