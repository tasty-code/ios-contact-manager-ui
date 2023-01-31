//
//  ViewController.swift
//  ContactManagerUI
//
//  Created by DONGWOOK SEO on 2023/01/30.
//

import UIKit

final class ViewController: UIViewController {

    private let dummyPerson: Person = Person(name: "알리", age: 10, phoneNum: "010-000-0000")

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
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "ContactListCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)

        cell.textLabel?.text = dummyPerson.name + "(\(dummyPerson.age))"
        cell.detailTextLabel?.text = dummyPerson.phoneNum

        return cell
    }
}
