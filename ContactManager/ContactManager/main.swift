//
//  main.swift
//  ContactManager
//
//  Created by DONGWOOK SEO on 2023/01/30.
//

import Foundation

private func main() {
    let programManager: ProgramManagerProtocol = ProgramManager(inputEditor: InputEditor(validator: Validator()),
                                                                outputEditor: OutputEditor())
    programManager.runProgram()
}

main()
