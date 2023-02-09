//
//  UITextFieldExtensions.swift
//  ContactManagerUI
//
//  Created by 김용재 on 2023/02/07.
//

import UIKit

extension UITextField {
    
    func addDoneButtonToKeyboard(doneAction: Selector?) {
        let doneToolbar: UIToolbar = UIToolbar()
        doneToolbar.barStyle = UIBarStyle.default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: nil, action: doneAction)
        
        doneToolbar.setItems([flexSpace, done], animated: false)
        doneToolbar.sizeToFit()
        
        self.inputAccessoryView = doneToolbar
    }
    
    func addHyphenAndDoneButtonToKeyboard(doneAction: Selector?, hyphenAction: Selector?) {
        let hyphenAndDoneToolbar: UIToolbar = UIToolbar()
        hyphenAndDoneToolbar.barStyle = UIBarStyle.default
        
        let hyphen = UIBarButtonItem(title: "—", style: .plain, target: nil, action: hyphenAction)
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: doneAction)

        hyphenAndDoneToolbar.setItems([hyphen, flexSpace, done], animated: false)
        hyphenAndDoneToolbar.sizeToFit()
        
        self.inputAccessoryView = hyphenAndDoneToolbar
    }
}
