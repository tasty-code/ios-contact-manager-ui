import XCTest
@testable import ContactManager

final class ContactManagerTests: XCTestCase {
    var sut: Validation!
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = Validation()
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
    }
    
    func test_이름이_허용되는_경우() throws {
        let names = [
            "한글입니다",
            "다",
            "NewJunsung",
            "A B",
            "A B C",
            "특수문자포함❤️",
            "123123",
            "한글 입니다",
            "!@#$"
        ]
        
        for name in names {
            XCTAssertNoThrow(try Validation().check(name: name))
        }
    }
    
    func test_나이가_허용되는_경우() throws {
        let ages = [
            "0",
            "1",
            "10",
            "100",
            "999",
            "1 0",
            "1 0 0",
            "5 2"
        ]
        
        for age in ages {
            XCTAssertNoThrow(try Validation().check(age: age))
        }
    }
    
    func test_전화번호가_허용되는_경우() throws {
        let phoneNumbers = [
            "01011112222",
            "010-9876-8321",
            "021234567",
            "03101010202",
            "031-123-4567",
            "032-321-2331",
            "03211112222",
            "033-412-1232",
            "033-1231-1231",
        ]
        
        for phoneNumber in phoneNumbers {
            XCTAssertNoThrow(try Validation().check(phoneNumber: phoneNumber))
        }
    }
    
    func test_이름이_허용되지_않는_경우() throws {
        let names = [
            "",
            " ",
            " 이름이름",
            " 123 12321 3123"
        ]
        
        for name in names {
            XCTAssertThrowsError(try Validation().check(name: name)) { error in
                XCTAssertEqual(error as? CheckContactErrors, CheckContactErrors.invalidName)
            }
        }
    }
    
    func test_나이가_허용되지_않는_경우() throws {
        let ages = [
            "",
            " ",
            "-1",
            "-100",
            "1000",
            "912312",
            "91 2312",
            "이름",
            "dada",
            "01011112222",
            "010-2222-3333",
        ]
        
        for age in ages {
            XCTAssertThrowsError(try Validation().check(age: age)) { error in
                XCTAssertEqual(error as? CheckContactErrors, CheckContactErrors.invalidAge)
            }
        }
    }
    
    func test_전화번호가_허용되지_않는_경우() throws {
        let phoneNumbers = [
            "",
            " ",
            "30",
            "013-432-235",
            "119",
            "112",
            "숫자를넣어보자",
            "숫자를 넣어보자",
            " 숫자를 넣어보자",
            " 숫자를넣어보자",
            "abcdefghi"
        ]
        
        for phoneNumber in phoneNumbers {
            XCTAssertThrowsError(try Validation().check(phoneNumber: phoneNumber)) { error in
                XCTAssertEqual(error as? CheckContactErrors, CheckContactErrors.invalidPhoneNumber)
            }
        }
    }
}
