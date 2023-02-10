//
//  ContactTableViewCell.swift
//  ContactManagerUI
//
//  Created by DONGWOOK SEO on 2023/02/09.
//

import UIKit

final class ContactTableViewCell: UITableViewCell {
    
    @IBOutlet weak private var name: UILabel!
    @IBOutlet weak private var age: UILabel!
    @IBOutlet weak private var phoneNumber: UILabel!
    
    func setData(with person: Person) {
        name.text = person.name
        age.text = String(person.age) + " 세"
        phoneNumber.text = person.phoneNum
    }
}
