//
//  ContactManager.swift
//  Contact-Manager-iOS
//
//  Created by Doyoung An on 1/5/24.
//

protocol ContactManager {
    func showUpAllContacts() -> [Contact]
    func addNewContacts(contact: Contact)
    func deleteContact(at index: Int)
    func updateContact(at index: Int, with updateContact: Contact)
}
