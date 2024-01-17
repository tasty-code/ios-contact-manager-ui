final class ContactManager {
    private var contactDictionary = [String: Contact]()
    var contacts: [Contact] {
        return Array(contactDictionary.values)
    }
    
    @discardableResult
    func findContact(phoneNumber: String) throws -> Contact {
        guard let contact = contactDictionary[phoneNumber] else {
            throw ContactError.nonExistentContact
        }
        return contact
    }
    
    func deleteContact(phoneNumber: String) throws {
        try findContact(phoneNumber: phoneNumber)
        contactDictionary.removeValue(forKey: phoneNumber)
    }
    
    func updateContact(existingPhoneNumber: String, _ newContact: Contact) throws {
        try findContact(phoneNumber: existingPhoneNumber)
        
        if (existingPhoneNumber == newContact.phoneNumber) {
            contactDictionary[existingPhoneNumber] = newContact
        } else {
            try addContact(newContact)
            contactDictionary.removeValue(forKey: existingPhoneNumber)
        }
    }
}

extension ContactManager {
    enum ContactError: Error {
        case nonExistentContact
        case duplicateContact
    }
}

extension ContactManager: ContactAdding {
    func addContact(_ contact: Contact) throws {
        guard contactDictionary[contact.phoneNumber] == nil else {
            throw ContactError.duplicateContact
        }
        contactDictionary[contact.phoneNumber] = contact
    }
}

protocol ContactAdding {
    func addContact(_ contact: Contact) throws
}
