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
  
  func test_이름이_비었으면_false () {
    let result = manager.nameValidate("")
    XCTAssertFalse(result)
  }
  
  func test_나이가_3자리_수_초과하면_false () {
    let result = manager.ageValidate(1000)
    XCTAssertFalse(result)
  }
  
  func test_나이가_음수면_false () {
    let result = manager.ageValidate(-5)
    XCTAssertFalse(result)
  }
  
  func test_phone_번호가_9자리_미만이면_false () {
    let result = manager.phoneValidate("05-343-2443")
    XCTAssertFalse(result)
  }
  
  func test_phone_번호가_9자리면_true () {
    let result = manager.phoneValidate("050-343-2443")
    XCTAssertTrue(result)
  }

//    override func setUpWithError() throws {
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//    }
//
//    override func tearDownWithError() throws {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//    }
//
//    func testExample() throws {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//        // Any test you write for XCTest can be annotated as throws and async.
//        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
//        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
//    }
//
//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
