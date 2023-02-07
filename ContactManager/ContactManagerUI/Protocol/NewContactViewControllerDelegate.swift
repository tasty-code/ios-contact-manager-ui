//
//  NewContactViewControllerDelegate.swift
//  ContactManagerUI
//
//  Created by jun on 2023/02/07.
//

import Foundation

protocol NewContactViewControllerDelegate: NSObject {
    func sendData(contact: Contact)
}
