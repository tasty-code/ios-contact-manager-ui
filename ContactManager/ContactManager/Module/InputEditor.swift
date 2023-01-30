//
//  InputEditor.swift
//  ContactManager
//
//  Created by devxsby on 2023/01/30.
//

import Foundation

struct InputEditor {
    
    let validator = Validator()
    let outputEditor = OutputEditor()
    
    private func getUserInput() throws -> String {
        guard let userInput = readLine() else {
            throw Errors.readFail
        }
        return userInput
    }
    
    private func getContactInfo() throws -> UserInputModel {
        let userInput = try getUserInput()
        let isEmpty = validator.checkInputEmpty(with: userInput)
        
        if isEmpty {
            throw Errors.noUserInput
        }
        
        let trimmedData = trimming(of: userInput)
        return convertToUserInputModel(with: trimmedData)
    }
    
    func selectMenu() throws -> Bool {
        let userInput = try getUserInput()
        let menu = Menu(rawValue: userInput)
        
        switch menu {
        case .add:
            addProgram()
            return true
        case .showList:
            showListProgram()
            return true
        case .search:
            searchProgram()
            return true
        case .exit:
            outputEditor.printTerminateProgram()
            return false
        default:
            throw Errors.invalidSelect
        }
    }
    
    private func trimming(of str: String) -> [String] {
        let unspacedString = str.components(separatedBy: " ").joined()
        let splitedString = unspacedString.split(separator: "/").map { String($0) }
        return splitedString
    }
    
    private func convertToUserInputModel(with str: [String]) -> UserInputModel {
        return UserInputModel(name: str[0], age: str[1], phoneNum: str[2])
    }
    
    private func requestValidation(with model: UserInputModel) throws -> Person {
        do {
            let person = try validator.checkValidAgeAndNum(input: model)
            return person
        } catch {
            throw error
        }
    }
    
    private func addProgram() {
        outputEditor.askContactInfo()
        do {
            let userInput = try getContactInfo()
            let person = try requestValidation(with: userInput)
            outputEditor.printResult(with: person)
            DataManager.shared.setContact(person)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func showListProgram() {
        let contactsList = DataManager.shared.getContactsList()
        contactsList.forEach { print($0, terminator: "\n") }
        print("")
    }
    
    private func searchProgram() {
        var contactList: [Person] = []
        outputEditor.printAskName()
        
        guard let userInput = readLine() else { return }
        let person = DataManager.shared.getContactsData()
        contactList = person.filter { $0.name == userInput }
        
        if contactList.isEmpty {
            print("연락처에 \(userInput) 이(가) 없습니다.")
        } else {
            contactList.forEach{ print("- \($0.name) / \($0.age) / \($0.phoneNum)", terminator: "\n")}
        }
        print("")
    }
}
