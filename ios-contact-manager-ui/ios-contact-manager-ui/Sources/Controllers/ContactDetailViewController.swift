//
//  ContactDetailViewController.swift
//  ios-contact-manager-ui
//
//  Created by Lee minyeol on 1/11/24.
//

import UIKit

class ContactDetailViewController: UIViewController {

    private let detailView = DetailView()
    
    override func loadView() {
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }


}
