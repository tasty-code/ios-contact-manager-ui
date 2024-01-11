//
//  addContactView.swift
//  contact-management
//
//  Created by 박찬호 on 1/11/24.
//

import UIKit

class addContactView: UIViewController {
    private var contactListStorage: ContactListStorage?
    
    required init?(coder: NSCoder) {
        self.contactListStorage = nil
        super.init(coder: coder)
    }
    
    init?(coder: NSCoder, contactListStorage: ContactListStorage) {
        self.contactListStorage = contactListStorage
        super.init(coder: coder)
    }
    
    
}
