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
    
    mutating func updateContact(_ contact: Contact) throws {
        try findContact(phoneNumber: contact.phoneNumber)
        contactDictionary[contact.phoneNumber] = contact
    }
    
    mutating func deleteContact(phoneNumber: String) throws {
        try findContact(phoneNumber: phoneNumber)
        contactDictionary.removeValue(forKey: phoneNumber)
    }
}

enum ContactManagerError: Error {
    case nonExistentContact
    case duplicateContact
}
