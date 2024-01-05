//
//  ContactFileManager.swift
//  ContactManager
//
//  Created by 윤진영 on 1/5/24.
//

import UIKit

final class ContactFileManager {
    
    var contact: [Contact] = []
    
    func loadJson() {
        let jsonDecoder: JSONDecoder = JSONDecoder()
        guard let dataAsset: NSDataAsset = NSDataAsset(name: "contact") else {
            print("File Not Found Error")
            return
        }
        do {
            self.contact = try jsonDecoder.decode([Contact].self, from: dataAsset.data)
        } catch {
            print(error)
        }
    }
}
