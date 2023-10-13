# 연락처 앱 프로젝트 SwainYun, 범

@ehgud0670

## 참여자 : SwainYun, 범
|[SwainYun](https://github.com/Remaked-Swain)|[범](https://github.com/snowy-summer)|
|:--:|:--:|
|<img src="https://avatars.githubusercontent.com/u/99116619?v=4" width=300>|<img src="https://avatars.githubusercontent.com/u/118453865?v=4" width=300>|


----------------------------------------
## UML
![](https://hackmd.io/_uploads/rJK37ISW6.png)


----------------------------------------
## [STEP 1] 프로젝트 진행 중 고민한 내용
* **UITableVIewController vs UIViewController**
테이블 뷰를 구현하는 방식
    1. 기존의 ViewController에 테이블 뷰를 따로 만들어서 하는 방식
    ```swift
    import UIKit

    final class ViewController: UIViewController {
        @IBOutlet weak var tableView: UITableView!

        private var contactsModel: ContactsModel!

        override func viewDidLoad() {
            super.viewDidLoad()
            configure()
        }

        private func configure() {
            self.contactsModel = ContactsModel()
        }
    }

    extension ViewController: UITableViewDelegate, UITableViewDataSource {
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath) as? ContactTableViewCell else { return UITableViewCell() }
            let contact = self.contactsModel.readContact(indexPath: indexPath)
            var content = cell.defaultContentConfiguration()
            content.text = "\(contact.name)(\(contact.age))"
            content.secondaryText = "\(contact.phoneNumber)"
            cell.contentConfiguration = content

            return cell
        }

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return contactsModel.count
        }
    }

    ```
    
    2. TableViewController를 사용하는 방식
    ```swift
    final class TableViewController: UITableViewController {
    private var contactsModel: ContactsModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        self.contactsModel = ContactsModel()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactsModel.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath) as? ContactTableViewCell else { return UITableViewCell() }
        let contact = self.contactsModel.readContact(indexPath: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = "\(contact.name)(\(contact.age))"
        content.secondaryText = "\(contact.phoneNumber)"
        cell.contentConfiguration = content
        
        return cell
    }
    
    // 생략...
    ```
> 어떤 기준으로 UITableViewController와 UIVIewController를 사용해서 TableVIew를 구현하는지 모르겠습니다.
> UITableViewController 문서를 보니 이미 UIViewController를 상속받고 있고 Delegate와 DataSource 프로토콜을 채택하고 있었습니다.

* **Cell Customizing**
테이블 뷰의 셀을 표현하는 방법에 관하여
    1. cell.textLabel?.text에 값을 대입하는 방식
    2. 먼저 내용을 설정한 후 cell.contentConfiguration에 설정한 내용을 대입하는 방식
> 1번 방식의 경우 deprecated 되었습니다. 이의 대안으로 2번 방식을 알게 되었습니다.
> cell의 기본적인 구성(default nil)을 본따서 text, secondaryText 등을 세팅하고 이것을 cell에 넣어주는 식으로 이해하였습니다.
> 어떤 배경에서 1번 방식이 deprecated 되었는지, 그리고 2번 방식으로 얻을 수 있는 이점이 무엇일지 궁금합니다.

----------------------------------------------------------
## [STEP 2] 프로젝트 진행 중 고민한 내용
* **전화번호 형식 포매팅과 텍스트 뷰 반영**
```swift
override func viewDidLoad() {
    super.viewDidLoad()
    self.configureViewComponents()
    self.phoneNumberTextField.addTarget(self, action: #selector(phoneNumberTextFieldEditingChanged), for: .editingChanged)
}

@objc private func phoneNumberTextFieldEditingChanged(_ textField: UITextField) {
    guard let text = textField.text?.replacingOccurrences(of: "-", with: "") else { return }
    textField.text = text.formatted(by: "-")
}
```
> 텍스트 필드 값이 변경될 때마다 포매팅하고 다시 대입하는 과정이 혹시 많은 부하를 초래할 수 있는지 궁금하고, 그러하다면 어떤 방향으로 변경해야 좋을지 알고 싶습니다.

* **removeObserver()**
```swift
// MARK: Observer Pattern Methods by using Notification Center
extension TableViewController {
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
> 이렇게 추가한 옵저버는 언제, 어디서, 어떻게 취소해야 적절한지 궁금합니다.
> Combine에서는 AnyCancellable로 보관해두고 수신 대기가 끝나면 취소해두는게 안전하다고 설명하던데,
> 옵저버, 구독자를 취소하는 이유부터 근본적인 호기심이 생겼습니다.

* **Add subviews to cell**
```swift
func configureCell2(item contact: Contact) {
    let titleLabel = UILabel()
    titleLabel.text = "\(contact.name)(\(contact.age))"
    let subTitleLabel = UILabel()
    subTitleLabel.text = contact.phoneNumber

    self.contentView.addSubview(titleLabel)
    self.contentView.addSubview(subTitleLabel)
}
```
> 코드 베이스로 셀 컨텐츠를 그리는 코드가 맞을까요?
> 레이아웃 제약사항 설정하는 부분이 없는게 걱정 됐었지만,
> 오히려 제약사항을 설정해주니 ContentView의 구성을 마음대로 바꾸지말라며 에러메세지한테 혼났습니다.
> 이 부분은 왜 커스터마이징 할 수 없게 해놓았을까요...?

- Cell Layout constraints를 마음대로 할 수 없는 이유에 관한 고찰 (23.10.12 추가)
    - 아마도 지금 셀의 스타일이 "Subtitle" 이기 때문에,그리고 이 스타일에 정해져 있는 고유한 형태가 있기 때문에 컴파일러는 에러메세지를 내뿜는 것이라고 추론.
'만약 자유 형태의 셀을 꾸미고 싶다면 Custom 셀 스타일을 쓰면 되겠다.' 라고 생각합니다.
- tableView.reloadData() 메서드의 오버헤드 걱정에 관한 궁금증 (23.10.12 추가)
    - 동기들과 reloadData() 메서드의 동작에 대해서 이야기를 나눴습니다.
섹션 개수 확인, 행 개수 확인 등 아예 전체 테이블 뷰의 아이템들을 다시 그리는 것 같아요.
현재 프로젝트의 기능으로는 연락처 정보 하나씩 추가하거나 수정하는 것 뿐이니까
셀 하나만 insertRow, 또는 reloadRows를 쓰는게 더 성능 측면에서는 낫지 않겠냐는 의견으로 모아졌어요.
위 메서드를 사용하기 위해서는 셀 위치를 특정할 수 있는 데이터(IndexPath라던지)를 매개변수로 전달해야 하니까
NotificationCenter로 다루는 알림 object에 indexPath를 담아서 보낸다면 위의 걱정이 해소될 것 같거든요?!?!
어떻게 생각하시는지 고견 여쭤봅니다...

### 의문점
1. 옵저버 패턴과 델리게이트 패턴 통한 데이터 관리 방법 말고 filemanager를 통해 json파일을 읽어 오거나 수정을 하는 것을 통한 데이터 관리 방법도 생각을 해보고 시도를 해보려 하는데 filemanager를 통한 방법도 많이 사용하는지 궁금합니다

-------------------------------------------------------
