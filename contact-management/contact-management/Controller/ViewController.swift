//
//  ViewController.swift
//  contact-management
//
//  Created by Roh on 1/2/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let contactListStorage = ContactListStorage()
        
        // test 코드
        contactListStorage.addContact(name: "noam", phoneNumber: "112", age: 28)
        contactListStorage.addContact(name: "hero", phoneNumber: "119", age: 18)
        contactListStorage.addContact(name: "billon", phoneNumber: "114", age: 17)
        
        do {
            let checkContact1 = try contactListStorage.showContact(who: "hero")
            let checkContact2 = try contactListStorage.showContact(who: "noam")
            let checkContact3 = try contactListStorage.showContact(who: "billon")
            print(checkContact1)
            print(checkContact2)
            print(checkContact3)
            try contactListStorage.deleteContact(name: "noam")
        }
        catch {
            
        }
        
    }

}

