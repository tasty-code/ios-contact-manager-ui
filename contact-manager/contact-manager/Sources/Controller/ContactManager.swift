struct ContactManager {
    private(set) var contactDictionary = [String: Contact]()
    
    mutating func addContact(_ contact: Contact) throws {
        guard contactDictionary[contact.phoneNumber] == nil else {
            throw ContactManagerError.duplicateContact
        }
        contactDictionary[contact.phoneNumber] = contact
    }
    
    @discardableResult
    func findContact(phoneNumber: String) throws -> Contact {
        guard let contact = contactDictionary[phoneNumber] else {
            throw ContactManagerError.nonExistentContact
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

enum ContactManagerError: Error {
    case nonExistentContact
    case duplicateContact
}
