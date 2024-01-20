//
//  ContactUnavailableConfiguration.swift
//  ContactManager
//
//  Created by Effie on 1/18/24.
//

import UIKit

enum ContactUnavailableConfiguration {
    static let noContacts: UIContentUnavailableConfiguration = {
        var config = UIContentUnavailableConfiguration.empty()
        config.image = UIImage(systemName: "person.crop.circle")
        config.text = "저장된 연락처 없음"
        config.secondaryText = "저장된 연락처 목록이 여기 표시됩니다."
        return config
    }()
    
    static let noSearchingResults: UIContentUnavailableConfiguration = {
        var config = UIContentUnavailableConfiguration.search()
        config.text = "검색 결과 없음"
        config.secondaryText = "조건과 일치하는 검색 결과가 없습니다."
        return config
    }()
}
