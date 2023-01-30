# ios-contact-manager-ui

# ☎️ 연락처 관리 프로그램

# 🌲 프로젝트 구조 설명

Model 

ᄂ`Contact` - 이름, 나이, 전화번호 정보를 가지는 연락처 모델 

ᄂ`InputError` - 사용자 입력 에러 타입

ᄂ`UserMenu` - 사용자 입력 메뉴

ᄂ`InfoMessage` - 사용자 안내 문구

Manager

ᄂ`PhoneBookManager` - 연락처들을 갖고 있고, 연락처 추가 / 조회 / 검색의 역할을 수행

ᄂ`InputManager` - 사용자 입력을 검증하고 Contact 타입으로 변환하는 역할을 수행

Extensions

ᄂ`ExtensionArray` - 배열 관련 extension (subscript에 안전하게 접근하는 함수)

ᄂ`ExtensionString` - String 관련 extensions

`main.swift` - Command Line Tools 기본 실행 파일

### 동작 로직 (순서도)
![image](https://user-images.githubusercontent.com/113027391/210038068-711bb064-b7a1-4e21-8e76-0ca5ee61f163.png)



## ⚠️ 프로젝트 구현시 요구사항

### 코드 - 요구사항

- 느낌표(`!`) 사용하지 않기
- Swift API Design Guidelines 문서대로 코드 작성하기
- 주석 남기지 않기
- 라이브러리 사용하지 않기
- 들여쓰기 3번 초과하지 않기

### 기능 - 요구사항

- [ 사용자 메뉴 표시 ]
    - 사용자에게 동작을 선택할 메뉴를 표기
    - `1, 2, 3, x` 외 입력을 받으면 잘못된 입력을 알리고 다시 메뉴를 출력
- [ 연락처 추가 ] - 사용자 입력 수신 및 검증, 연락처 추가
    - 입력은 영문으로만 진행합니다. (한글 자소분리 현상은 해결 대상이 아닙니다.)
    - 올바른 사용자 입력 형태 : `[이름] / [나이] / [연락처]` / `[이름]/[나이]/[연락처]`
    - `이름`: 사용자가 중간에 띄어쓰기를 하더라도 띄어쓰기를 제거합니다.
    - `나이`: 숫자로만 입력해야하며, 세 자리수 이하여야 합니다.
    - `연락처`: 중간에 - 로 구분하며, - 는 두 개 존재해야합니다. - 를 제외하고 숫자는 9자리 이상이어야 합니다.
    - 입력받은 내용을 검증하여 연락처를 추가하고 사용자에게 안내문을 출력합니다.
- [ 연락처 목록 보기 ]
    - 이름순으로 출력하기
- [ 연락처 검색 ]
    - 이름을 기준으로 사용자 검색
    - 검색 결과의 출력 순서는 입력받았던 순서와 무관

## 📺 기능 구현

- [ 사용자 메뉴 표시 ]
    - 프로그램 실행: `main.swift` 파일의 `execute()` 함수를 실행
    - 사용자 입력 메뉴 체크 및 실행: `readLine()` 으로 사용자 input 을 받고, `enum UserMenu` 의 케이스에 해당하는지를 검증
        - 해당하지 않을 시 `InputError.invalidMenu` 문구 출력 후 `execute()` 다시 실행
        - 해당할 시, 각 케이스에 따른 PhoneBookManager 의 함수 실행
            1. 연락처 추가  → `PhoneBookManager.addContact()`
            2. 연락처 조회 → `PhoneBookManager.lookUpContacts()`
            3. 연락처 검색 → `PhoneBookManager.searchContact()`
1. [ 연락처 추가 ] - 사용자 입력 수신 및 검증, 연락처 추가
    - 사용자 입력 연락처 검증
        - `InputManager.parse()` 를 호출하여, 입력 결과가 알맞은 폼인지 검증하고 슬래시를 기준으로 파싱
        - `InputManager.getContact()` 를 호출하며 파싱한 결과값을 넘겨서 `Contact` 객체 반환
            - 검증에 실패할 시, 각 경우에 따른 `InputError` 타입을 `throw` 함으로서 에러메시지 출력
    - 생성한 `Contact` 객체를 `contacts: Set<Contact>`에 삽입
        - 중복된 값이어서 삽입에 실패할 시, 사용자 문구 출력
        - 삽입에 성공 할 시, 연락처 정보 출력
2. [ 연락처 목록 보기 ] 
    - 연락처 데이터가 비어있는지 체크
        - 비어있으면 안내문구 출력
    - 비어있지 않으면 `Set` 형태의 `contacts` 를 이름을 기준으로 정렬 
    (`contacts.sorted { $0.name < $1.name` )
    - `forEach`로 각 연락처의 정보를 출력
3. [ 연락처 검색 ]
    - 검색 할 이름의 키워드를 입력 받고, 해당 키워드를 이름에 포함하고 있는 contact 를 filter
    ( `contacts.filter { $0.isNameContaining(keyword: userInput) }` )
        - 검색된 결과가 없을 시, 안내 문구 출력
    - 검색된 결과의 각 연락처의 정보를 출력
- 각 기능을 실행한 후, 다시 `execute()` 를 실행 (x 입력 시 다시 실행하지 않고 바로 종료)

# 💡 문제 & 해결

### Xcode 버전문제에 따라  split(separator:) 메서드 호출 시 에러 발생

- `split(separator:)` 에 공백이 포함된 “ / “ 를 넘겼는데, 빌드 타겟을 13.0 미만으로 바꾸어 실행시 해당 문제가 발생하는 것으로 보아 버전 문제로 파악
따라서 13.0 미만의 버전에서도 사용 가능한 `components` 메서드를 사용한 코드로 변경
- `separator` 파라미터에 두 글자 이상을 넘길 때에 생기는 문제인데 기본 `split` 메서드는 한 글자만 허용했었고, 두 글자 이상 허용하는 메서드는 macOS 13.0 이후에 추가되었다는 것을 학습

### 배열에서 index 직접 접근시 런타임 에러 발생위험 존재

- Array의`Extension`을 추가하고, indices 를 체크 해 접근하는 방식으로 변경. 
사용 시 옵셔널 바인딩 통해 값을 사용하도록 함

```swift
extension Array {
    subscript(safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
}
```

# 📚 학습 내용

### InputError 구현 시, LocalizedError 를 채택한 이유

- 최초 구현 시 `Error` 타입을 채택해, `printError` 함수를 구현하고호출하는 do - catch 구문에서 InputError 타입일 경우에 printError() 를 호출하게 분기 처리를 따로 해줘야 했었으나,
- `public var errorDescription: String?` 를 정의해서 `error.localizedDescription` 으로 에러 문구 출력을 할 수 있음
- `errorDescription` 구현 시, `switch self` 형식으로 구현하는 것을 권장
(에러의 경우 서버 응답 코드와 rawValue를 매칭해서 사용하곤 하기 때문에 rawValue에 출력 문구를 사용하는건 지양)

### Struct 와 Enum 의 선택 기준

- 저장 속성을 갖지 않고 `static func` 들만 갖고 있는 타입은 굳이 인스턴스화를 하지 않게끔 `enum` 으로 구현

### **PhoneBookManager 의 구현 타입 선택**

- `PhoneBookManager` 의 역할:
    - 연락처 데이터 모델인 `Contact` 들을 가지며 연락처 추가, 연락처 조회, 연락처 검색 의 역할을 수행
    - 처음엔, 사용자 메뉴 입력을 받고 체크 하여 연락처 추가,조회,검색 기능을 실행하는 역할도 부여하였으나, 메뉴 입력을 받고 체크하는 역할은 PhoneBookManager 의 역할이라기 보다는 프로그램 실행파일의 역할로 분리해도 될 것 같다는 생각에 기존 main.swift 파일의 execute 함수로 분리함
- 해당 `PhoneBookManager` 객체는 프로그램 전체에서 단 1번만 인스턴스화 되면 된다는 포인트에서 싱글턴 패턴의 `final class` 로 구현
    - 차후 확장성을 생각했을 때 해당 PhoneBookManager 가 다른 컨트롤러에서 사용될 수 있다고 생각했는데, 동일한 하나의 연락처 데이터를 공유해야 한다고 생각 함

### **연락처 데이터를 담는 컬렉션 타입 선택**

- 연락처를 “추가” 하는 기능의 연산을 우선으로 고려
    - 이름, 나이, 연락처가 모두 동일한 기존에 존재하는 연락처가 있는지를 조회하고, 
    이미 있을 경우에는 데이터를 추가하지 않는다는 것을 가정으로 하였을 때
    - Array 로 구현하게 되면 매번 O(n) 의 조회를 해야 하기에 Hashing 하고 중복을 허용하여 삽입에 O(1) 의 복잡도를 지닌 Set 으로 구현
>>>>>>> phoneBook/main
