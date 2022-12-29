//
//  PrintMessage.swift
//  ContactManager
//
//  Created by 김보미 on 2022/12/21.
//

import Foundation

enum PrintMessage: String, CustomStringConvertible {
    case startComment = "1) 연락처 추가 2) 연락처 목록보기 3) 연락처 검색 x) 종료\n메뉴를 선택해주세요 : "
    case requestContactInformation = "연락처 정보를 입력해주세요 : "
    case correctContactInformation = "입력한 정보는 "
    case requestToSearchName = "연락처에서 찾을 이름을 입력해주세요 : "
    case invalidName = "입력한 이름 정보가 잘못되었습니다. 입력 형식을 확인해주세요.\n"
    case invalidAge = "입력한 나이 정보가 잘못되었습니다. 입력 형식을 확인해주세요.\n"
    case invalidPhoneNumber = "입력한 연락처 정보가 잘못되었습니다. 입력 형식을 확인해주세요.\n"
    case invalidFormat = "입력한 정보의 형식이 맞지않습니다. 올바른 형식을 확인해주세요.\n"
    case nothingUserInput = "아무것도 입력되지 않았습니다. 입력 형식을 확인해주세요.\n"
    case choiceWrorngMenu = "선택이 잘못되었습니다 확인 후 다시 입력해주세요.\n"
    case exitProgram = "[프로그램 종료]"
    
    static func validUserInput(value: ContactInformation?) {
        guard let contact = value else {
            print(PrintMessage.invalidFormat)
            return
        }
        print(PrintMessage.correctContactInformation, terminator: "")
        print("\(contact.age)세 \(contact.name)(\(contact.phoneNumber))입니다. \n")

    }
    
    static func viewContact(list: [ContactInformation]) {
        list.forEach { element in
            print("- \(element.name) / \(element.age) / \(element.phoneNumber)")
        }
    }
    
    static func searchContact(list: [ContactInformation], word: String) {
        let confirmContactArray = list.filter{$0.name == word}
        guard !confirmContactArray.isEmpty else {
            print("연락처에 \(word) 이(가) 없습니다.")
            return
        }
        confirmContactArray.forEach { element in
            print("- \(element.name) / \(element.age) / \(element.phoneNumber)")
        }
    }
    
    var description: String {
        return self.rawValue
    }
}
