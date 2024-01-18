//
//  ContactUnavailableConfiguration.swift
//  ContactManager
//
//  Created by Effie on 1/18/24.
//

import UIKit

enum ContactUnavailableConfiguration {
    static let noContacts: UIContentUnavailableConfiguration = {
        var emptyConfig = UIContentUnavailableConfiguration.empty()
        emptyConfig.image = UIImage(systemName: "person.crop.circle")
        emptyConfig.text = "저장된 연락처 없음"
        emptyConfig.secondaryText = "저장된 연락처 목록이 여기 표시됩니다."
        return emptyConfig
    }()
    
    static let noSearchingResults: UIContentUnavailableConfiguration = {
        var emptyConfig = UIContentUnavailableConfiguration.empty()
        emptyConfig.image = UIImage(systemName: "person.crop.circle")
        emptyConfig.text = "저장된 연락처 없음"
        emptyConfig.secondaryText = "저장된 연락처 목록이 여기 표시됩니다."
        return emptyConfig
    }()
}
