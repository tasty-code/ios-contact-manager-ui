struct ContactManager {
    private(set) var contactList: [String: Contact]
    
    mutating func addContact(contact: Contact) {
        contactList[contact.phoneNumber] = contact
    }
    
    func getContact(phoneNumber: String) -> Contact? {
        return contactList[phoneNumber]
    }
    
    mutating func updateContact(contact: Contact) {
        contactList[contact.phoneNumber] = contact
    }
    
    mutating func deleteContact(phoneNumber: String) {
        contactList.removeValue(forKey: phoneNumber)
    }

}
