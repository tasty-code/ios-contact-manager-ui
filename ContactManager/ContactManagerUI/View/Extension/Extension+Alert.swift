//
//  Extension+Alert.swift
//  ContactManagerUI
//
//  Created by Jason on 2023/02/08.
//

import UIKit

extension AddNewContactViewController {
    internal func successAlert(message: String) {
        let success = UIAlertAction(title: "확인", style: .default, handler: nil)
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        
        alert.addAction(success)

        present(alert, animated: true, completion: nil)
    }
    
    internal func cancelConfirmAlert() {
        let alert = UIAlertController(title: nil, message: "정말로 취소하시겠습니까?", preferredStyle: .alert)
        let allowAction = UIAlertAction(title: "예", style: .destructive, handler: { action in
            self.dismiss(animated: true)
        })
        let cancleAction = UIAlertAction(title: "아니오", style: .cancel, handler: nil)
        
        alert.addAction(allowAction)
        alert.addAction(cancleAction)

        present(alert, animated: true, completion: nil)
    }
}
