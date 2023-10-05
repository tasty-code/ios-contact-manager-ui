//
//  ContactCell.swift
//  ios-contact-manager-ui
//
//  Created by 김진웅 on 2023/10/05.
//

import UIKit

class ContactCell: UITableViewCell {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subtitleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
