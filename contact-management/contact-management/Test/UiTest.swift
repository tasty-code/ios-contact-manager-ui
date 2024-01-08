//
//  UiTest.swift
//  contact-management
//
//  Created by 박찬호 on 1/5/24.
//

import UIKit

extension ContactListView {
    func UI_테스트(Storage contactListStorage: ContactListStorage) {
        contactListStorage.addContact(ContactList(name: "노움", phoneNumber: "010-1111-1111", age: 20))
        contactListStorage.addContact(ContactList(name: "샘", phoneNumber: "010-2222-2222", age: 21))
        contactListStorage.addContact(ContactList(name: "폴", phoneNumber: "010-3333-3333", age: 22))
    }
}
