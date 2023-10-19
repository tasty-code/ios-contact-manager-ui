//
//  CustomTableViewCell.swift
//  ContactManager
//
//  Created by 전성수 on 10/17/23.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var name:UILabel!
    @IBOutlet weak var age:UILabel!
    @IBOutlet weak var digits:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
