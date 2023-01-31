//
//  InputEditor.swift
//  ContactManager
//
//  Created by devxsby on 2023/01/30.
//

import Foundation

protocol InputEditorProtocol {
    var validator: ValidatorProtocol { get }
    var outputEditor: OutputEditorProtocol { get }
    func selectMenu() throws -> Bool
}

struct InputEditor: InputEditorProtocol {
    
    var validator: ValidatorProtocol
    var outputEditor: OutputEditorProtocol
    
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
    
    private func trimming(of str: String) -> [String] {
        let unspacedString = str.components(separatedBy: " ").joined()
        let splitedString = unspacedString.split(separator: "/").map { String($0) }
        return splitedString
    }
    
    private func convertToUserInputModel(with userInfo: [String]) -> UserInputModel {
        return UserInputModel(name: userInfo[0], age: userInfo[1], phoneNum: userInfo[2])
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
            let contactInfo = try getContactInfo()
            let person = try requestValidation(with: contactInfo)
            outputEditor.printResult(with: person)
            DataManager.shared.setContact(person)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func showListProgram() {
        let contactsList = DataManager.shared.getContactsList()
        contactsList.forEach { outputEditor.showContactList($0) }
        outputEditor.printEmptyString()
    }
    
    private func searchProgram() {
        outputEditor.askPersonName()
        
        do {
            let userInput = try getUserInput()
            let contactList = DataManager.shared.getContactsData().filter { $0.name == userInput }
            
            if contactList.isEmpty {
                outputEditor.printEmptyUser(userInput)
            } else {
                contactList.forEach{ outputEditor.searchValidUser($0.name, $0.age, $0.phoneNum) }
            }
            outputEditor.printEmptyString()
        } catch {
            print(error.localizedDescription)
        }
    }
}
