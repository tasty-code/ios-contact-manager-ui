
import Foundation

@propertyWrapper
struct NotifyContactInfoChange {
    
    var value: [User]
    
    var wrappedValue: [User] {
        get { value }
        set { value = newValue}
    }
    
    init(wrappedValue: [User]) {
        self.value = wrappedValue
    }
}
