//
//  CustomAlert.swift
//  ContactManager
//
//  Created by 유니 & L on 1/12/24.
//

import UIKit

protocol CustomAlert {
    func showAlert(message: String, actions: [UIAlertAction])
}

protocol UpdateNewContact: AnyObject {
    func updateNewContact()
}
