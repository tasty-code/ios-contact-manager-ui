//
//  ContactManagerTests.swift
//  ContactManagerTests
//
//  Created by Rarla on 2023/10/11.
//

import XCTest
@testable import ContactManager

final class ContactManagerTests: XCTestCase {
  var manager = ContactManager()
  
  func test_이름이_비었으면_false () throws {
    // given
    let input = ""
    
    // then
    XCTAssertThrowsError(try manager.addContact(nameText: input, ageText: "22", phoneText: "010-4234-6212")) { error in
      XCTAssertEqual(error.localizedDescription, ValidationError.nameValidationError.localizedDescription)
    }
  }
  
  func test_나이가_3자리_수_초과하면_false () {
    // given
    let input = "1000"
    
    // then
    XCTAssertThrowsError(try manager.addContact(nameText: "yohan", ageText: input, phoneText: "010-4234-6212")) { error in
      XCTAssertEqual(error.localizedDescription, ValidationError.ageValidationError.localizedDescription)
    }
  }
  
  func test_나이가_음수면_false () {
    // given
    let input = "-5"
    
    // then
    XCTAssertThrowsError(try manager.addContact(nameText: "yohan", ageText: input, phoneText: "010-4234-6212")) { error in
      XCTAssertEqual(error.localizedDescription, ValidationError.ageValidationError.localizedDescription)
    }
  }
  
  func test_phone_번호가_9자리_미만이면_false() {
    // given
    let input = "05-3432"
    
    // then
    XCTAssertThrowsError(try manager.addContact(nameText: "yohan", ageText: "22", phoneText: input)) { error in
      XCTAssertEqual(error.localizedDescription, ValidationError.phoneValidationError.localizedDescription)
    }
  }
  
  func test_phone_번호가_9자리면_true() throws {
    // given
    let input = "050-343-2443"
    
    // when
    let result: () = try manager.addContact(nameText: "yohan", ageText: "22", phoneText: input)

    // then
    XCTAssertNoThrow(result)
  }
}
