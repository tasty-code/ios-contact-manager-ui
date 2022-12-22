//
//  PhoneBookManager.swift
//  PhoneBookManager
//
//  Created by 신동오 on 2022/12/21.
//

import Foundation

struct PhoneBookManager {
    func run() {
        ConsoleView.printInputMessage()
        let userInput = ConsoleView.userInput()
        
        let inputArray = InputManager.splitInput(from: userInput)
        
        guard inputArray.count == 3 else { return print("입력이 올바르지 않습니다.")}
        
        guard let name = InputManager.getName(from: inputArray) else { return print("이름 오류")}
        
        guard let age = InputManager.getAge(from: inputArray) else { return print("입력한 나이정보가 잘못되었습니다. 입력 형식을 확인해주세요")}
        
        guard let phoneNumber = InputManager.getPhoneNumber(from: inputArray) else { return print("입력한 연락처정보가 잘못되었습니다. 입력 형식을 확인해 주세요")}
        
        ConsoleView.printInitialInputInfo(name: name, age: age, phoneNumber: phoneNumber)
        
    }
}
