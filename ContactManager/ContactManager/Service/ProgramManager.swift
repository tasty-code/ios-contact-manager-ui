//
//  ProgramManager.swift
//  ContactManager
//
//  Created by devxsby on 2023/01/30.
//

import Foundation

protocol ProgramManagerProtocol {
    var inputEditor: InputEditorProtocol { get }
}

final class ProgramManager: ProgramManagerProtocol {
    
    var inputEditor: InputEditorProtocol
    private var shouldRun: Bool = true
    
    init(inputEditor: InputEditorProtocol) {
        self.inputEditor = inputEditor
    }
    
    func runProgram() {
        while shouldRun {
            inputEditor.outputEditor.printMenu()
            do {
                shouldRun = try inputEditor.selectMenu()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    private func terminateProgram() {
        shouldRun = false
    }
}
