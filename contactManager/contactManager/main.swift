import Foundation

while !isMenuInputError {
    print(GuideText.menu)
    print(GuideText.selectMenu,terminator: "")
    guard let input = readLine(), let menu = MenuType(rawValue: input) else{
        print("선택이 잘못되었습니다. 확인 후 다시 입력해주세요.\n")
        continue
    }
    switch menu{
    case .addContact:
        addContact()
    case .viewContactList:
        for contact in contacts.sorted(by: {$0.name < $1.name}) {
            print(contact.description)
        }
        print("")
        continue
    case .findContact:
        print("연락처에서 찾을 이름을 입력해주세요 : ", terminator: "")
        guard let inputValue = readLine() else {
            continue
        }
        findContact(inputName: inputValue)
        continue
    case .exit:
        isMenuInputError = true
        print("\n[프로그램 종료]")
    }
}
