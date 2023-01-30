//
//  ProgramManager.swift
//  ContactManager
//
//  Created by devxsby on 2023/01/30.
//

import Foundation

final class ProgramManager {
    
    let inputEditor = InputEditor()
    let outputEditor = OutputEditor()
    
    private var shouldRun: Bool = true
    
    func runProgram() {
        while shouldRun {
            outputEditor.printMenu()
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
