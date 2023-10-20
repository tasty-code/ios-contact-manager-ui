//
//  ContactFormViewControllerDelegate.swift
//  ios-contact-manager
//
//  Created by Swain Yun on 10/17/23.
//

import Foundation

protocol ContactFormViewControllerDelegate: AnyObject {
    func createContact(_ contactCreateViewController: ContactCreateViewController, _ contact: Contact)
    func updateContact(_ contactEditViewController: ContactEditViewController, _ contact: Contact)
}
