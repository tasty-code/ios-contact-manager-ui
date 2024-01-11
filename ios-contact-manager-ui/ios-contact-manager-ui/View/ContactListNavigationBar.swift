//
//  ContactListNavigationBar.swift
//  ios-contact-manager-ui
//
//  Created by Kim EenSung on 1/11/24.
//

import UIKit

class ContactListNavigationBar: UINavigationBar {
    private let addtionButton: UIBarButtonItem = {
        let addtionButton = UIBarButtonItem()
        addtionButton.image = UIImage(systemName: "plus")
        return addtionButton
    }()
    private let titleItem: UINavigationItem = {
        let titleItem = UINavigationItem(title: "연락처")
        return titleItem
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        titleItem.rightBarButtonItem = addtionButton
        self.pushItem(titleItem, animated: true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
