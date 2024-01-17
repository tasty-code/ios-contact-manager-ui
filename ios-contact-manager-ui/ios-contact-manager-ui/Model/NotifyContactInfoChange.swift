
import Foundation

@propertyWrapper
struct NotifyContactInfoChange {
    
    var value: [User]
    var updateChange: (() -> Void)?
    
    var wrappedValue: [User] {
        get { value }
        set { 
            updateChange?()
            value = newValue
        }
    }
    
    init(wrappedValue: [User]) {
        self.value = wrappedValue
    }
}

