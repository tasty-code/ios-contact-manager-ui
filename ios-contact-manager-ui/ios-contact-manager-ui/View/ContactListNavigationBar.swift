//
//  ContactListNavigationBar.swift
//  ios-contact-manager-ui
//
//  Created by Kim EenSung on 1/11/24.
//

import UIKit

final class ContactListNavigationBar: UINavigationBar {
    private let additionButton: UIBarButtonItem = {
        let additionButton = UIBarButtonItem()
        additionButton.image = UIImage(systemName: "plus")
        additionButton.action = #selector(ContactListViewController.presentContactsAdditionModalView)
        return additionButton
    }()
    private let titleItem: UINavigationItem = {
        let titleItem = UINavigationItem(title: "연락처")
        return titleItem
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        titleItem.rightBarButtonItem = additionButton
        self.pushItem(titleItem, animated: true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
