struct ContactManager {
    private(set) var contactDictionary: [String: Contact]
    
    mutating func addContact(_ contact: Contact) throws {
        guard contactDictionary[contact.phoneNumber] == nil else {
            throw ContactManagerError.duplicateContact
        }
        contactDictionary[contact.phoneNumber] = contact
    }
    
    func getContact(phoneNumber: String) throws -> Contact {
        guard let contact = contactDictionary[phoneNumber] else {
            throw ContactManagerError.nonExistentContact
        }
        return contact
    }
    
    mutating func updateContact(_ contact: Contact) throws {
        try validateContactExists(phoneNumber: contact.phoneNumber)
        contactDictionary[contact.phoneNumber] = contact
    }
    
    mutating func deleteContact(phoneNumber: String) throws {
        try validateContactExists(phoneNumber: phoneNumber)
        contactDictionary.removeValue(forKey: phoneNumber)
    }
    
    private func validateContactExists(phoneNumber: String) throws {
        if contactDictionary[phoneNumber] != nil {
            throw ContactManagerError.nonExistentContact
        }
    }

}

enum ContactManagerError: Error {
    case nonExistentContact
    case duplicateContact
}
