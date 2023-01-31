//
//  ViewController.swift
//  ContactManagerUI
//
//  Created by jun on 2023/01/31.
//

import UIKit

final class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let contactTableViewCell = "ContactTableViewCell"

    override func viewDidLoad() {
        super.viewDidLoad()

        let nibName = UINib(nibName: contactTableViewCell, bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: contactTableViewCell)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: contactTableViewCell, for: indexPath) as! ContactTableViewCell

        cell.title.text = "Joo(5)"
        cell.subtitle.text = "010-1234-1234"

        return cell
    }


}
