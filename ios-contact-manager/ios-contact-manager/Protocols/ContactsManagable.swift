//
//  ContactsManagable.swift
//  ios-contact-manager
//
//  Created by Swain Yun on 10/10/23.
//

import Foundation

protocol ContactsManagable: AnyObject {
    func createContact(_ contact: Contact)
    func updateContact(_ contact: Contact, _ indexPath: IndexPath)
}
