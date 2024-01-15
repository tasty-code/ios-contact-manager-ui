
import Foundation

@propertyWrapper
struct NotifyContactInfoChange {
    
    var value: [User]
    var updateChange: (() -> Void)?
    
    var wrappedValue: [User] {
        get { value }
        set { 
            value = newValue
            updateChange?()
        }
    }
    
    init(wrappedValue: [User]) {
        self.value = wrappedValue
        updateChange?()
    }
}
