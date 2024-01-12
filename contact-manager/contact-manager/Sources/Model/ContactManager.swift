final class ContactManager {
    private var contactDictionary: [String: Contact]
    var contacts: [Contact] {
        return Array(contactDictionary.values)
    }
    
    init(contactDictionary: [String : Contact] = [String: Contact]()) {
        self.contactDictionary = contactDictionary
    }
    
    func addContact(_ contact: Contact) throws {
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
