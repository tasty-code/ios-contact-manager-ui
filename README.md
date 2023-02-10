# iOS_contactManager UI README (Miro & Lust3r)

## 📇  프로젝트 동작
![ezgif com-resize](https://user-images.githubusercontent.com/85781941/218033893-450a3676-152e-4032-a7e1-0953a78f56e1.gif)
---

## 🕵🏻 역할 분배

| Folder | Name | Type | Role |
| --- | --- | --- | --- |
| ViewControllers | ContactViewController | UIViewController | 연락처 정보를 담은 테이블 뷰 화면을 구현하는 뷰 컨트롤러 |
|  | AddContactViewController | UIViewController | 연락처를 추가하는 화면을 구현하는 뷰 컨트롤러 |
| Models | DummyContactInfo | enums | 더미 데이터를 생성하기위한 열거형 타입을 모아둔 파일 |
| Storyboards | Main | Storyboard | 연락처 정보를 담은 테이블 뷰 화면을 구현한 스토리보드 |
| Extensions | UITextFieldExtensions | UITextField extension | 텍스트 필드의 툴 바를 구성하는 메소드를 모아둔 파일  |

➕ 연락처 관리 프로젝트(Console 버젼)속 파일들을 target 설정하여 활용하였습니다.

---

## Step1 - iOS App Target 추가

[PR #3 | Step1 - iOS App Target 추가](https://github.com/tasty-code/ios-contact-manager-ui/pull/3)

### 핵심 내용

- **Target에 대한 개념 이해**
    - 기존의 연락처 관리 프로그램 프로젝트에 UIKit App Target을 추가
- **Target Membership 개념 이해**
    - ContactManager Target의 주요 파일을 ContactManagerUI의 Target Membership으로 추가

---

## Step2 - 연락처 목록 구현

[PR #11 | Step2 - 연락처 목록 구현](https://github.com/tasty-code/ios-contact-manager-ui/pull/11)

### 핵심 내용

- **Table View에 대한 개념 이해** (연락처 목록을 화면에 표시)
    - `defaultContentConfiguration` 를 활용하여 `cellForRowAt` 메소드 구현하기
    - Table View 구현 시 필수 메소드 학습

---

## Step3 - 연락처 추가 기능 구현

[PR #16 | Step3 - 연락처 추가 기능 구현](https://github.com/tasty-code/ios-contact-manager-ui/pull/16)

### 핵심 내용

- **Navigation Controller, View Controller에 대한 이해**
    - present, push 방식에 대한 고민 (모달 방식, 네비게이션 방식)
        - 연락처 목록 화면 우상단 버튼을 통해 연락처 추가 화면에 진입
- **Code UI로 구현하는 방법 학습**
    - 코드를 통하여 StackView(`addArrangedSubView`)를 구성하는 방법 학습
    - 코드를 통하여 UIView를 생성하는 방법 학습
    - 각 UI요소의 Constraint를 주는 방법 학습
- **TextField 키보드에 대한 이해**
    - TextField의 키보드 종류에 대한 학습
    - ToolBar를 추가하는 방식에 대한 학습(`#selector`, `UIBarButtonItem`, `target-action pattern`)
- **Target membership의 활용(입력 데이터 유효성 검사)**
    - 기존 모델의 메서드를 활용하여 입력된 데이터의 유효성을 검사
- **UIAlertController에 대한 이해**
    - 취소, 저장 버튼에 대한 이벤트 표시(`UIAlertAction`)

---

## 📓 학습내용 요점

### 1. Target Membership

스위프트 패키지의 기본 블록. 하나의 product와 workspace에서 product를 빌드하기 위한 지침(instruction)들을 포함하며, 하나의 Xcode Project는 여러 개의 target을 가질 수 있고, 하나의 target은 하나의 product를 만들어 낸다.

이번 프로젝트에서는 기존에 콘솔로 진행하였던 contactManager가 하나의 Target이고,
앱 환경을 위해 구현한 ContactManagerUI가 또 하나의 Target이라고 볼 수 있다.

> 참고 : [공식 문서](https://developer.apple.com/documentation/packagedescription/target)
> 

### 2. defaultContentConfiguration()

Retrieves a default list content configuration for the cell’s style.

```swift
private func configure(cell: UITableViewCell, at indexPath: IndexPath) -> UIListContentConfiguration {
        var content = cell.defaultContentConfiguration()
        
        content.text = "\(contacts[indexPath.row].name)(\(contacts[indexPath.row].age))"
        content.secondaryText = "\(contacts[indexPath.row].phoneNumber)"
        content.textProperties.font = .systemFont(ofSize: 16)
        content.secondaryTextProperties.font = .systemFont(ofSize: 16)
        
        return content
    }
```

기존 Label의 text를 수정하기 위한 프로퍼티인 textLabel이 deprecated되어 이에 접근하기 위해서는 defaultContentConfiguration() 메서드를 사용해야 했다.

이를 통해 cell의 text와, fontSize를 변경하여 cell의 contentConfiguration에 넣어주는 것으로 반영하였다.

> 참고 : [공식 문서](https://developer.apple.com/documentation/uikit/uitableviewcell/3601058-defaultcontentconfiguration)
> 

### 3. Programmatically coding

ContactViewController.swift를 Storyboard로 구성했기에 AddContactViewController.swift는 코드로 UI를 구성해보고자 하였다.

```swift
private var newContactNavigationBar: UINavigationBar = {
        let navigationBar = UINavigationBar()
        
        let navigationItem = UINavigationItem(title: "새 연락처")
        let cancelItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: nil, action: #selector(cancelButtonTapped))
        let saveItem = UIBarButtonItem(barButtonSystemItem: .save, target: nil, action: #selector(saveButtonTapped))
        
        navigationItem.leftBarButtonItem = cancelItem
        navigationItem.rightBarButtonItem = saveItem
        navigationBar.setItems([navigationItem], animated: false)
        
        return navigationBar
    }()
```

NavigationBar, Label, TextField, StackView 등 하나하나 코드로 인스턴스를 생성하고, 세부사항 설정해주고, View에 더해주는 것까지 전부 코드로 진행해보았다.

### 4. NSLayoutConstraint

The relationship between two user interface objects that must be satisfied by the constraint-based layout system.

```swift
newContactNavigationBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            newContactNavigationBar.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            newContactNavigationBar.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            newContactNavigationBar.topAnchor.constraint(equalTo: safeArea.topAnchor),
            newContactNavigationBar.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
```

3번과 같이 코드로 UI를 구성했기 때문에 제약조건도 코드로 줘야 했다.

translatesAutoresizingMaskIntoConstraints의 기본값인 true 상태라면 View의 크기와 위치는 고정된 상태이기 때문에 우리가 원하는 제약조건을 주기 위해서는 false 처리를 해야 했고, NSLayoutConstraint를 사용하여 각 UI Object에 다양한 제약조건을 줄 수 있었다.

> 참고 : [공식 문서](https://developer.apple.com/documentation/uikit/nslayoutconstraint)
> 

### 5. reloadData()

Reloads the rows and sections of the table view.

```swift
extension ContactViewController: AddContactViewDelegate {
    
    func reloadTableView() {
        contactsTableView.reloadData()
    }
}
```

addContactViewController를 통해 새 연락처를 입력 받은 후 원래 ContactViewController로 돌아갔을 때, 업데이트 된 연락처 정보로 tableView를 보여줄 필요가 있어 reloadData() 메서드를 사용하였다.

> 참고 : [공식 문서](https://developer.apple.com/documentation/uikit/uitableview/1614862-reloaddata)
> 

### 6. firstResponder

The window’s first responder.

```swift
override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        addSubview()
        configureLayout()
        nameTextField.becomeFirstResponder()
}
```

addContactViewController 창이 열림과 동시에 이름 입력 field에 포커스 되었으면 하여 responder를 학습하였다. 

> 참고 : [공식 문서](https://developer.apple.com/documentation/uikit/uitableview/1614862-reloaddata)
> 

---
