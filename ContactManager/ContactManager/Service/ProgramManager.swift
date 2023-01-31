//
//  ProgramManager.swift
//  ContactManager
//
//  Created by devxsby on 2023/01/30.
//

import Foundation

protocol ProgramManagerProtocol {
    var inputEditor: InputEditorProtocol { get }
    var outputEditor: OutputEditorProtocol { get }
}

final class ProgramManager: ProgramManagerProtocol {
    
    var inputEditor: InputEditorProtocol
    var outputEditor: OutputEditorProtocol
    
    private let dataManager = DataManager.shared
    
    private var shouldRun: Bool = true
    
    init(inputEditor: InputEditorProtocol, outputEditor: OutputEditorProtocol) {
        self.inputEditor = inputEditor
        self.outputEditor = outputEditor
    }
    
    func runProgram() {
        while shouldRun {
            outputEditor.printMenu()
            do {
                let menu = try inputEditor.selectMenu()
                
                switch menu {
                case .add:
                    addProgram()
                case .showList:
                    showListProgram()
                case .search:
                    searchProgram()
                case .exit:
                    outputEditor.printTerminateProgram()
                    terminateProgram()
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    private func terminateProgram() {
        shouldRun = false
    }
}

extension ProgramManager {
    
    private func addProgram() {
        outputEditor.askContactInfo()
        do {
            let contactInfo = try inputEditor.getContactInfo()
            let person = try inputEditor.requestValidation(with: contactInfo)
            outputEditor.printResult(with: person)
            dataManager.setContact(person)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func showListProgram() {
        let contactsList = dataManager.getContactsList()
        contactsList.forEach { outputEditor.showContactList($0) }
        outputEditor.printEmptyString()
    }
    
    private func searchProgram() {
        outputEditor.askPersonName()
        do {
            let userInput = try inputEditor.getUserInput()
            let contactList = dataManager.getContactsData().filter { $0.name == userInput }
            
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
