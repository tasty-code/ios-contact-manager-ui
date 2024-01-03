//
//  ios_contact_manager_uiTests.swift
//  ios-contact-manager-uiTests
//
//  Created by Kim EenSung on 1/3/24.
//

import XCTest
@testable import ios_contact_manager_ui

final class ios_contact_manager_uiTests: XCTestCase {
    
    var sut: ContactList!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = ContactList()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_updateContactList_호출시_제대로추가가되나요() {
        //given
        let input: Contact = Contact(name: "댄", contact: "010-1111-2222", age: 35)
        let expectation: Array<Contact> = [Contact(name: "댄", contact: "010-1111-2222", age: 35)]
        //when
        sut.updateContactList(contact: input)
        //then
        XCTAssertEqual(sut.showContactList(), expectation)
    }
    
//    func test_showContactList_호출시_

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
