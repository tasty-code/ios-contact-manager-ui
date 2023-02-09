//
//  main.swift
//  ContactManager
//
//  Created by 김보미 on 2022/12/21.
//

import Foundation

let detector = Detector()
let convertor = Converter()
let checker = Checker()
let contactManager = ContactManager(detector: detector, convertor: convertor, checker: checker)

contactManager.startProcess()
