//
//  UITextFieldExtensions.swift
//  ContactManagerUI
//
//  Created by 김용재 on 2023/02/07.
//

import UIKit

extension UITextField {
    
    func addDoneButtonToKeyboard(doneAction: Selector?) {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 300, height: 40))
        doneToolbar.barStyle = UIBarStyle.default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: nil, action: doneAction)
        
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.inputAccessoryView = doneToolbar
    }
    
    func addHyphenAndDoneButtonToKeyboard(doneAction: Selector?, hyphenAction: Selector?) {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 300, height: 40))
        doneToolbar.barStyle = UIBarStyle.default
        
        let hyphen = UIBarButtonItem(title: "—", style: .plain, target: nil, action: hyphenAction)
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: doneAction)

        var items = [UIBarButtonItem]()
        items.append(hyphen)
        items.append(flexSpace)
        items.append(done)
        
        doneToolbar.items = items
        
        self.inputAccessoryView = doneToolbar
    }
}
