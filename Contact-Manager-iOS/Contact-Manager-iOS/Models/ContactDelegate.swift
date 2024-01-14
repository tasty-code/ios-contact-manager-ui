//
//  ContactDelegate.swift
//  Contact-Manager-iOS
//
//  Created by Doyoung An on 1/12/24.
//

protocol ContactDelegate: AnyObject {
    func addNewContact(newContact: Contact)
    func updatedContact(contactId id: Int, with updateContact: Contact)
}
