//
//  ContactCreationViewController.swift
//  ContactManager
//
//  Created by Wonji Ha on 2023/10/11.
//

import UIKit

class ContactCreationViewController: UIViewController {

       override func viewDidLoad() {
           super.viewDidLoad()
           setup()
       }
       
       func setup() {
           self.view.backgroundColor = .systemBackground
           setNavigationBar()
       }
       
       func setNavigationBar() {
           let navbar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
           navbar.backgroundColor = .clear
           navbar.barTintColor = .systemBackground
           
           navbar.setBackgroundImage(UIImage(), for: .default)
           navbar.shadowImage = UIImage()
           navbar.layer.shadowColor = UIColor.clear.cgColor
           navbar.isTranslucent = true
           
           let navItem = UINavigationItem(title: "새 연락처")
           
           let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(didTapCancelButton))
           let saveButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(didTapSaveButton))
           
           navItem.leftBarButtonItem = cancelButton
           navItem.rightBarButtonItem = saveButton
           
           navbar.setItems([navItem], animated: false)
           self.view.addSubview(navbar)
       }
       
       @objc func didTapCancelButton(_ sender: UINavigationItem) {
           dismiss(animated: true)
       }
    
       @objc func didTapSaveButton(_ sender: UINavigationItem) {
           print("save tapped")
       }
}
