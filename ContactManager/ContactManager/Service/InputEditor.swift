//
//  InputEditor.swift
//  ContactManager
//
//  Created by devxsby on 2023/01/30.
//

import Foundation

protocol InputEditorProtocol {
    func selectMenu() throws -> Menu
    func getUserInput() throws -> String
    func getContactInfo() throws -> UserInputModel
    func requestValidation(with inputtedModel: UserInputModel) throws -> Person
}

struct InputEditor: InputEditorProtocol {
    
    var validator: ValidatorProtocol
    
    func selectMenu() throws -> Menu {
        let userInput = try getUserInput()
        guard let menu = Menu(rawValue: userInput) else {
            throw Errors.invalidSelect
        }
        return menu
    }
    
    func getUserInput() throws -> String {
        guard let userInput = readLine() else {
            throw Errors.readFail
        }
        return userInput
    }
    
    func getContactInfo() throws -> UserInputModel {
        let userInput = try getUserInput()
        let isEmpty = validator.checkInputEmpty(with: userInput)
        
        if isEmpty {
            throw Errors.noUserInput
        }
        
        let trimmedData = trimming(of: userInput)
        return convertToUserInputModel(with: trimmedData)
    }
    
    func requestValidation(with inputtedModel: UserInputModel) throws -> Person {
        do {
            let person = try validator.checkValidAgeAndNum(input: inputtedModel)
            return person
        } catch {
            throw error
        }
    }
    
    private func trimming(of str: String) -> [String] {
        let unspacedString = str.components(separatedBy: " ").joined()
        let splitedString = unspacedString.split(separator: "/").map { String($0) }
        return splitedString
    }
    
    private func convertToUserInputModel(with userInfo: [String]) -> UserInputModel {
        return UserInputModel(name: userInfo[0], age: userInfo[1], phoneNum: userInfo[2])
    }
}
