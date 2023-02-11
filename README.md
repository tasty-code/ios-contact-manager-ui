# ios-cantact-manager-UI
## 💰Team BUJA 
🏃🏻🏃🏻‍♂️💨 **프로젝트 기간:** `23.01.30` ~ `23.02.10`

|<img src="https://avatars.githubusercontent.com/u/71758542?v=4" width=200  style="border-radius: 70%">|<img src="https://avatars.githubusercontent.com/u/92699723?v=4" width=200 style="border-radius: 70%">|
|:---:|:---:|
|[Blu](https://github.com/bomyuniverse)|[Jason](https://github.com/JasonLee0223)|

----
[[(Ver.Console) Previous Project] ios-contact-manager](https://github.com/calledBlu/ios-cantact-manager)

<a href ="#1-Step1---iOS App Target 추가">Step1 - iOS App Target 추가</a>

<a href ="#2-Step2---연락처 목록 구현">Step2 - 연락처 목록 구현</a>

<a href ="#3-Step3---연락처 추가 기능 구현
">Step3 - 연락처 추가 기능 구현
</a>

----
## 🔖 역할 분배
|Controller|역할|
|:---|:---|
|ContactManagerTableViewController|- 프로젝트 실행시 첫 화면 <br/>- 우측 상단의 '+'버튼을 통해 AddNewContactViewController 화면으로 Modal형태로 넘어간다. <br/>- 새로운 연락처가 저장되면 reload()를 통해 업데이트한다.|
|AddNewContactViewController|- 이름, 나이, 연락처 순서로 데이터를 입력할 수 있도록 한다. <br/>- 화면 상단의 좌,우측으로 저장할 수 있거나 입력을 취소하고 첫 화면으로 돌아간다.|

|View|역할|
|:---|:---|
|UITableView|TableView 형태로 연락처의 목록을 보여준다.|
|Alert|사용자 입력에 맞춰 잘못입력하면 올바르게 입력하라는 경고문을 Alert형태로 띄워준다.|

|struct/class|역할|
|:---|:---|
|JSONManangement|Local File인 `dummy.json`파일을 불러와서 ContactInformation의 JSON형태로 Decoding하여 Load해준다.|

|enum|역할|
|:---|:---|
|JSONErrors|JSON Parsing 과정 중 에러가 발생하는 케이스를 정의 및 호출된다.|

|protocol|역할|
|:---|:---|
|ReusableTableViewCell|ReusableTableViewCell타입과 맞는 Cell만을 재사용하도록 한다.|
|SendContactDataDelegate|delegate를 통해 사용자가 Save 버튼을 누르면 ContactInformation형태로 저장한다.|
|JSONParsable|JSON Parsing에 관한 메서드 정의|

----

## Step1 - iOS App Target 추가
- 이전 프로젝트를 기반으로 UIKit App Target 추가
- ContactManager 타깃의 주요 파일을 ContactManagerUI의 타깃 멤버십 파일로 추가

기존의 프로젝트에 UI 버전을 추가 구현하기 위해 선행되어야 하는 단계로, 앱 타겟 설정 과정은 다음과 같다.

1. ContactManager의 프로젝트 설정에서 TARGETS 목록 하단의 + 버튼을 누른다.
2. iOS-App을 선택한다
3. ContactManagerUI로 네이밍 후 타겟을 생성한다.
4. ContactManager의 주요 파일의 인스펙터에서 ContactManagerUI를 타깃 멤버십 파일로 추가한다.

## Step2 - 연락처 목록 구현
[PR #7 | Step1~2 - iOS App Target 추가 및 연락처 목록 구현](https://github.com/tasty-code/ios-contact-manager-ui/pull/7#issue-1563831481)
- Table View를 활용하여 연락처 목록을 화면에 표시
- 각 행의 cell에 subtitle style 적용
- 학 행에 이름, 나이, 연락처 표시
- Dummy Data를 JSON으로 구현하여 Decoding 후Table View Data에 적용
- Protocol & Generic을 사용하여 cell identifier를 직접 입력하지 않고 메타타입으로 추론하여 재사용하도록 구현

UITableView를 이용하여 연락처들을 화면에 표시하는 기능을 구현하는 단계이다. Custom cell을 생성하지 않고, 스토리보드에서 기본적으로 제공하는 Prototype cell을 사용하였다.
iOS 14부터 `cell.textLabel?.text` 형태로 직접 접근하는 것이 아닌 content configuration을 통하여 cell을 구성하도록 개편되어서 해당 부분을 적용해 보았다.

### 🚀 적용하려고 노력해본 점
프로젝트 기간동안 JSON에 대해 학습하게되어 아직 Server로 부터 API 데이터를 받아오지는 못하지만
FilePath를 통해 JSON Parshing을 경험해보고자하였다!
처음은 Codable이 나오기 이전에 사용했던 `JSONSerialization`을 경험해보고 `JSONDecoder`를 사용하여 리펙토링해보는 경험을 해보았다.
```Swift
// JSONSerialization 사용
private func testJSON() {
    guard let filePath = Bundle.main.url(forResource: "Dummy", withExtension: "json") else { return }

    if let data = try? Data(contentsOf: filePath) {
        let json =  try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
        contactInfomation = json
    }

    if let contactInfo = contactInfomation["Dummy"] as? [[String: Any]] {
    contactInfo.forEach { contactData in
        nameArr.append(contactData["name"] as! String)
        ageArr.append(contactData["age"] as! String)
        phoneNumberArr.append(contactData["phoneNumber"] as! String)
    }
}
```

```Swift
// JSONDecoder 사용
func loadJSON<T>(_ filename: String) throws -> T where T : Decodable {
    let data: Data

    guard let filePath = Bundle.main.url(forResource: filename, withExtension: nil) else {
        print("\(filename) not found.")
        throw JSONErrors.notFoundJSONFile
    }

    do {
        data = try Data(contentsOf: filePath)
    } catch {
        print("Could not load \(filename): (error)")
        throw JSONErrors.notLoadData
    }

    do {
        let JSONDecoder = JSONDecoder()
        return try JSONDecoder.decode(T.self, from: data)
    } catch {
        print("Unable to decode \(filename): (error)")
        throw JSONErrors.unableToDecode
    }
}
```

## Step3 - 연락처 추가 기능 구현
[PR #19 | Step3 - 연락처 추가 기능 구현](https://github.com/tasty-code/ios-contact-manager-ui/pull/19)
- 네비게이션 컨트롤러 구현
- 연락처 목록 화면의 우상단 + 버튼을 통해 연락처 추가 화면으로 진입(Modal)
- AutoLayout 과 StackView를 활용하여 레이아웃 구성
- 각 필드에 맞는 키보드 종류 지정
    - 이름: ASCII Capable
    - 나이: Number Pad
    - 연락처: Phone Pad
- 새 연락처 추가 화면에서 네비게이션 바의 버튼을 누르는 경우 알림창이 나타나도록 구현
    - 취소 버튼을 누르면 정말 취소할 것인지 묻도록 알림창 구현
    - 저장 버튼을 누르면 입력한 정보가 올바르게 입력되었는지 확인하고 올바르지 않은 경우 해당 정보를, 
      올바른 경우 연락처 목록 화면으로 이동한 후 입력한 연락처를 목록에 추가하도록 구현
- 각 필드에 입력된 데이터를 save 버튼을 누를 때 검증하도록 구현
    - 이름은 사용자가 중간에 띄어쓰기를 하더라도 띄어쓰기를 제거
    - 나이는 숫자로만 입력, 세 자리수 이하
    - 연락처는 중간에 -로 구분, -는 두 개 존재, -을 제외하고 숫자는 9자리 이상

새 연락처를 추가할 수 있는 화면을 구성하고 연락처를 실제로 목록에 추가할 수 있도록 하는 단계이다. 
프로젝트 요구사항을 살펴본 후 Present Modal 방식으로 화면을 띄우기로 결정하였고, 코드를 통하여 구현하였다. 
data는 싱글톤을 채택하지 않고 있어서 delegate pattern을 채택하여 `SendContactDataDelegate`를 프로토콜로 구현, 연락처 목록 뷰에서 extension으로 함수를 구현하여 데이터를 전달받고 해당 데이터가 반영되도록 table view를 reload하도록 구현하였다.


---
## **🎯 트러블 슈팅**
### 1️⃣ API Design GuideLine에 맞춘 Refactoring
어떻게 보면 기능에 대한 문제점은 아니였지만 구현 과정에서 불편함이 있어 위 항목에서 다루었다.
이전 프로젝트를 진행하면서 API Design Guide를 최대한 따라가보려 하였지만 익숙하지 않다보니 
어려움이 발생하였고 아래의 코드를 예시로 좀 더 문장처럼 잘 읽히도록 리펙토링하였다.
```Swift
// ⛔️
class Converter {
    func convertToCharacter(this sentence: String) -> [Character] {
        var characterArray = [Character]()
        
        for index in sentence {
            characterArray.append(index)
        }
        return characterArray
    }
    
    func convertToString(_ word: [Character]) -> String {
        return String(word)
    }
}
```
```Swift
// ✅
class Converter {
    func renderToCharacter(_ sentence: String) -> [Character] {
        var characters = [Character]()
        
        for character in sentence {
            characters.append(character)
        }
        return characters
    }
    
    func renderToString(_ characters: [Character]) -> String {
        return String(characters)
    }
}
```
### 2️⃣ ReusableTableViewCell 프로토콜을 채택한 TableViewCell
Step1~2를 진행하면서 Review를 받은 내용에서 아래와 같은 의견을 받게되어 리펙토링을 하게 되었다.
prototype cell을 활용하면서 `cellIdentifier`를 직접 지정해주고, 이를 매개변수에 직접 할당하여 `dequeueReusableCell` 호출 시 사용할 수 있도록 하였으나, PR review 진행 중에 리뷰어의 추천으로  Protocol & Generic을 사용하여 휴먼 에러의 발생을 줄일 수 있도록 개선해 보았다.

> `cellIdentifier`는 결국 TableViewCell의 이름과 동일할 것인데 매번 저렇게 직접 작성하게되면, 휴먼에러가 발생할 확률도 있고 어느한쪽이 변경되었을때 다른쪽도 이름을 같이 변경해주어야할 것입니다.
이를 제네릭과 protocol을 사용해서 간편하게 처리하는 방법이 있으니 한 번 참고해보시면 좋을 것 같네요.

```Swift
// ⛔️
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cellIdentifier = "infoCell"
    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)

    var infoContent = cell.defaultContentConfiguration()
    infoContent.text = "Name(age)"
    infoContent.secondaryText = "contact-number"

    cell.contentConfiguration = infoContent

    return cell
}
```

```Swift
// ✅

// 구현부
// Protocol을 채택하여 필요한 Cell Type만 사용
extension UITableViewCell: ReusableTableViewCell {}

// UITableView를 확장하여 Custom Method 구현
extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>(cellClass: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Unable Dequeue Reusable")
        }
        return cell
    }
}

// 호출부 
override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(cellClass: UITableViewCell.self, for: indexPath)

    cell.configurationUpdateHandler = { cell, state in
        var infoContent = cell.defaultContentConfiguration().updated(for: state)
        infoContent.text = "\(self.contactInfomation[indexPath.row].name)(\(self.contactInfomation[indexPath.row].age))"
        infoContent.secondaryText = self.contactInfomation[indexPath.row].phoneNumber

        cell.accessoryType = .disclosureIndicator
        cell.contentConfiguration = infoContent
    }
    return cell
}
```

1. 해당 prototype cell이 `UITableViewCell`을 상속받게 한다.
2. prototype cell의 identifier를 `UITableViewCell`로 수정한다.

위의 과정으로 인해 리뷰어가 제안한 휴먼 에러의 발생 가능성은 줄어들었으나, 매번 cell의 타입을 지정해주는 작업이 불필요하다고 생각되어 메타 타입을 활용하는 방법으로 다시 한번 리팩토링을 진행하였다.

메타 타입을 활용하여 개선된 코드는 `dequeueReusableCell`를 호출할 때 해당 셀의 클래스의 메타타입을 매개변수로 전달하면 셀을 생성할 때 셀의 타입을 지정해 주어야 할 필요가 없으며 알아서 타입추론을 하고, 그에 맞는 `reuseIdentifier`를 정확하게 가져올 수 있게 되었다.

---
## 💻  **실행 화면**
<img src="https://user-images.githubusercontent.com/71758542/217981706-6b88c8f3-d8bc-461a-8125-4cb0363cbb56.gif">
