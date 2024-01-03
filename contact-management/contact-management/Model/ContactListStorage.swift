//
//  ContactListStorage.swift
//  contact-management
//
//  Created by Roh on 1/3/24.
//

import Foundation

final class ContactListStorage {
    
    var contactList: [String: ContactList]
//    private var contactListCnt: Int
    
    init() {
        // 이전 저장된 ContactList값을 저장
//        contactListCnt = 0
        contactList = [String: ContactList]()
    }
    
    // 연락처 보기
    func showContact(who name: String) throws -> ContactList {
        guard let newList: ContactList = contactList[name] else {
            throw ContactListError.ContactListNotFound
        }
        return newList
    }
    
    // 연락처 추가
    func addContact(
        name: String,
        phoneNumber: String,
        age: Int
    ) {
        let addList = ContactList(name: name, phoneNumber: phoneNumber, age: age)
        contactList[name] = addList
    }
    
    // 연락처 삭제
    func deleteContact(name: String) throws {
        guard let _ = contactList[name] else {
            throw ContactListError.ContactListNotFound
        }
        contactList[name] = nil
    }
    
    // 연락처 변경
    func changeContact(
        name: String,
        phoneNumber: String,
        age: Int
    ) throws {
        guard let _ = contactList[name] else {
            throw ContactListError.ContactListNotFound
        }
        let addList = ContactList(name: name, phoneNumber: phoneNumber, age: age)
        contactList[name] = addList
    }
    
}
