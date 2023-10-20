# 연락처 앱 프로젝트 SwainYun, 범

Thanks to: @ehgud0670

## 참여자 : SwainYun, 범
|[SwainYun](https://github.com/Remaked-Swain)|[범](https://github.com/snowy-summer)|
|:--:|:--:|
|<img src="https://avatars.githubusercontent.com/u/99116619?v=4" width=300>|<img src="https://avatars.githubusercontent.com/u/118453865?v=4" width=300>|

----------------------------------------
## UML

<img width="3236" alt="UML Diagrams (Community)-2" src="https://github.com/snowy-summer/ios-contact-manager-ui/assets/118453865/5120b984-b497-4415-9310-d4bf67c5367f">

--------------------------------------------

## 스크린샷
<p>
    <img src="https://hackmd.io/_uploads/SyP988yGp.png" width=250>
    <img src="https://hackmd.io/_uploads/HJNnL8JG6.png" width=250>
</p>
<p>
    <img src="https://hackmd.io/_uploads/r1D3U8Jza.png" width=250>
    <img src="https://hackmd.io/_uploads/H1uhU8yG6.png" width=250>
</p>

--------------------------------------------

## 프로젝트 핵심 내용
프로젝트 핵심 경험과 구현 내용을 소개합니다.

### TableView
* **TableView Delegate, DataSource**
```swift
override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.isFiltering ? self.filteredContactList.count : self.contactsModel.count
}

override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath) as? ContactTableViewCell else { return UITableViewCell() }

    if self.isFiltering {
        let contact = self.filteredContactList[indexPath.row]
        cell.configureCell(item: contact)
    } else {
        let contact = self.contactsModel.readContact(index: indexPath.row)
        cell.configureCell(item: contact)
    }

    return cell
}
```
    * 테이블 뷰의 필수 구현 메서드
    1. numberOfRowsInSection, 목록에 표시할 섹션의 개수를 나타냄.
    2. cellForRowAt, 특정 행의 셀을 표현함.
> 추가로 옵셔널한 프로토콜 메서드를 오버라이딩하여 테이블 뷰를 구성할 수 있다.

### Delegate Pattern
```swift
protocol ContactFormViewControllerDelegate: AnyObject {
    func createContact(_ contactCreateViewController: ContactCreateViewController, _ contact: Contact)
    func updateContact(_ contactEditViewController: ContactEditViewController, _ contact: Contact)
}
```

```swift
extension ContactListViewController: ContactFormViewControllerDelegate  {
    func createContact(_ contactCreateViewController: ContactCreateViewController, _ contact: Contact) {
        self.contactsModel.createContact(contact: contact)
    }
    
    func updateContact(_ contactEditViewController: ContactEditViewController, _ contact: Contact) {
        self.contactsModel.updateContact(contact: contact)
    }
}
```
    * ContactFormViewControllerDelegate
    1. 편집 화면의 데이터를 테이블 뷰로 전달할 수 있도록 함
    2. 위임하는 개체를 첫 번째 인자로 포함
> 델리게이션 프로토콜 네이밍 컨벤션에 따라서 위임 개체를 식별하고 추가적인 처리를 위하여 델리게이트 메서드의 첫 번째 인자를 전달함.
> 대리자는 이 프로토콜을 채택하고 알맞은 동작을 구현함.

### Observer Pattern


```swift
extension ContactsModel {
    private func notifyContactsDidChange() {
        let notificationName = NotificationType.contactsDidChange.name
        NotificationCenter.default.post(name: Notification.Name(notificationName), object: nil)
    }
}
```

```swift
extension ContactListViewController {
    private func addObserver() {
        let notificationName = NotificationType.contactsDidChange.name
        NotificationCenter.default.addObserver(
            forName: Notification.Name(notificationName),
            object: nil,
            queue: nil) { [weak self] _ in
                self?.tableView.reloadData()
            }
    }
}

```
> 기존의 delegate pattern으로 모델의 변화를 보내주고 했던 것을 모델과 ContactListViewController을 연결해주는 것으로 변경해 Observer Pattern을 적용시켰습니다.

### 비동기 클로저
```swift
final class ContactEditViewController: ContactFormViewController {
    // 생략...
    
    override func touchSaveBarButton(_ sender: UIBarButtonItem) {
        let name = self.nameTextField.text
        let age = self.ageTextField.text
        let phoneNumber = self.phoneNumberTextField.text
        
        do {
            try self.temporaryContainer.formatContact(name, age, phoneNumber)
            guard let contact = self.temporaryContainer.contact else { return }
            self.dismiss(animated: true) { [weak self] in
                guard let self = self else { return }
                self.delegate?.updateContact(self, contact)
            }
        } catch {
            guard let error = error as? ContactError else { return }
            self.presentErrorAlert(error)
        }
    }
}
```
    * 비동기 클로저
    1. 편집 화면에서 나가면 적절한 델리게이트 메서드를 호출.
    2. 비동기 클로저의 강한 참조를 약한 참조로 변경.
> `weak self` 키워드를 사용하여 캡쳐되는 클로저 동작을 약하게 해야 메모리 누수 발생 가능성을 줄일 수 있다.

### Cumtom Initializer
```swift
final class ContactEditViewController: ContactFormViewController {
    private let temporaryContainer: TemporaryContainer
    
    init?(coder: NSCoder, contact: Contact) {
        self.temporaryContainer = TemporaryContainer(contact: contact)
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Edit View Controller 생성 실패")
    }
    
    // 생략...
}
```
    * 생성자 만들기
    1. UIViewController의 필수 생성자와 내가 원하는 생성자를 정의하여 사용
