//
//  CustomTableViewCell.swift
//  ContactManager
//
//  Created by 전성수 on 10/17/23.
//

import UIKit

class ContactInformationTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var digits: UILabel!

    func drawCell(_ person: Person) {
        self.name.text = person.name
        self.age.text = person.age
        self.digits.text = person.digits
    }
}
