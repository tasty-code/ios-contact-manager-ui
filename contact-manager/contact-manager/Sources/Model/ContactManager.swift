struct ContactManager {
    private var contactDictionary: [String: Contact]
    
    init(contactDictionary: [String : Contact] = [String: Contact]()) {
        self.contactDictionary = contactDictionary
    }
    
    mutating func addContact(_ contact: Contact) throws {
        guard contactDictionary[contact.phoneNumber] == nil else {
            throw ContactManager.ContactError.duplicateContact
        }
        contactDictionary[contact.phoneNumber] = contact
    }
    
    @discardableResult
    func findContact(phoneNumber: String) throws -> Contact {
        guard let contact = contactDictionary[phoneNumber] else {
            throw ContactManager.ContactError.nonExistentContact
        }
        return contact
    }
    
    mutating func deleteContact(phoneNumber: String) throws {
        try findContact(phoneNumber: phoneNumber)
        contactDictionary.removeValue(forKey: phoneNumber)
    }
    
    mutating func updateContact(existingPhoneNumber: String, _ newContact: Contact) throws {
        try findContact(phoneNumber: existingPhoneNumber)
        
        if (existingPhoneNumber == newContact.phoneNumber) {
            contactDictionary[existingPhoneNumber] = newContact
        } else {
            try addContact(newContact)
            contactDictionary.removeValue(forKey: existingPhoneNumber)
        }
    }
}

extension ContactManager: ContactListProvider {
    var contacts: [Contact] {
        return Array(contactDictionary.values)
    }
}

extension ContactManager {
    enum ContactError: Error {
        case nonExistentContact
        case duplicateContact
    }
}

protocol ContactListProvider {
    var contacts: [Contact] { get }
}
