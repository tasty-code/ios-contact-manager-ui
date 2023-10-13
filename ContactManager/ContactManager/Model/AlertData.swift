//
//  AlertData.swift
//  ContactManager
//
//  Created by 김예준 on 10/13/23.
//

import UIKit

struct AlertData {
  var viewController: UIViewController
  var message: String
  var defaultButtonTitle: String
  var destructiveButtonTitle: String? = nil
  var destructiveAction: (() -> Void)? = nil
}
