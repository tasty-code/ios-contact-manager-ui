//
//  ContactsProtocol.swift
//  ios-contact-manager-ui
//
//  Created by 장우석 on 1/11/24.
//

import Foundation

protocol ContactsManageable: AnyObject {
    func create(_ contact: Contact)
    func update(_ contact: Contact)
    func delete(_ contact: Contact)
}

protocol ContactsApproachable: AnyObject {
    func sorted() -> Array<Contact>
}
