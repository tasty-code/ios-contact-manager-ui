//
//  ios_contact_manager_uiTests.swift
//  ios-contact-manager-uiTests
//
//  Created by Kim EenSung on 1/3/24.
//

import XCTest
@testable import ios_contact_manager_ui

final class ios_contact_manager_uiTests: XCTestCase {
    
    var sut: Contacts!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = Contacts()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_updateContactList_호출시_내부_딕셔너리에_제대로_추가될까요() {
        //given
        let input: Contact = Contact(name: "댄", contact: "010-1111-2222", age: 35)
        let expectation: Array<Contact> = [Contact(name: "댄", contact: "010-1111-2222", age: 35)]
        //when
        sut.updateContactList(contact: input)
        //then
        XCTAssertEqual(sut.sort(), expectation)
    }

    func test_deleteContactList_호출시_제대로삭제되나요() {
        //given
        let input: Array<Contact> = [Contact(name: "댄", contact: "010-1111-2222", age: 35), Contact(name: "Sidi", contact: "010-2222-1111", age: 36)]
        let expectation: Array<Contact> = [Contact(name: "댄", contact: "010-1111-2222", age: 35)]
        for contact in input {
            sut.updateContactList(contact: contact)
        }
        let contactToBeDeleted: Contact = sut.sort()[0]
        //when
        sut.delete(contactToBeDeleted)
        //then
        XCTAssertEqual(sut.sort(), expectation)
    }
    
    func test_showContactList_호출시_정렬이오름차순으로잘되나요() {
        //given
        let input: Array<Contact> = [Contact(name: "댄", contact: "010-1111-2222", age: 35), Contact(name: "Sidi", contact: "010-2222-1111", age: 36)]
        let expectation: Array<Contact> = [Contact(name: "Sidi", contact: "010-2222-1111", age: 36), Contact(name: "댄", contact: "010-1111-2222", age: 35)]
        //when
        for contact in input {
            sut.updateContactList(contact: contact)
        }
        //then
        XCTAssertEqual(sut.sort(), expectation)
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
