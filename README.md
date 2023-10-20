# 연락처 관리 앱
### Project Summary
- 연락처 관리앱 만들기 
    - 연락처 보기, 추가, 수정, 삭제등의 기능을 하는 앱을 제작
### 프로젝트 참여자 


| Howard | Mond |
| :--------: | :--------: |
| <img src="https://github.com/JEON-Sungsu/ios-contact-manager-ui/assets/63297236/f68a4f84-4f12-4c36-bbcb-85174f062211" width=150 height=150 />| <img src="https://github.com/JEON-Sungsu/ios-contact-manager-ui/assets/63297236/cf66941e-6f3c-49a5-8c9e-cb91bd755ef8" width=150 height=150 />|
### 작동 영상
| 기능 | 다이나믹타입 |
| :------: | :------: |
|      ![ContactManager-functionality](https://github.com/JEON-Sungsu/ios-contact-manager-ui/assets/63297236/133def26-4f73-46bb-b678-c43eb5ace1ab)|![ContactManager-Dynamictype](https://github.com/JEON-Sungsu/ios-contact-manager-ui/assets/63297236/c05e2d99-b6b0-4b7a-8cae-47a5f53d5e86)|


### 구현 내용
- [STEP1](https://github.com/tasty-code/ios-contact-manager-ui/pull/28#event-10614947211)
    - 연락처를 관리하기 위한 모델 생성 (연락처 보기, 추가, 삭제, 변경)
    - Table View를 활용하여 연락처 목록을 화면에 표시
    - 이름 기준으로 연락처 오름차순 정렬
    - 이름, 나이, 연락처 모두 같은 경우 중복 체크
- [STEP2](https://github.com/tasty-code/ios-contact-manager-ui/pull/36#event-10674153466)
    - 연락처 추가 화면 페이지 생성
    - 취소 버튼 선택 시 Alert 표시
    - 저장 버튼 선택 시 모든 정보에 대한 조건을 확인 후에 올바르게 입력되었다면 저장, 올바르지 않는다면 Alert 표시 (이름 : 띄어쓰기 제거, 나이 : 3자리수 이하, 연락처 : `-` 2개 존재, 숫자 9자리 이상)
- [STEP3](https://github.com/tasty-code/ios-contact-manager-ui/pull/41)
    - 연락처 목록에서 스와이프 삭제 기능 구현
    - Dynamic type 적용
    - 연락처 검색 기능 
    - Autolayout을 활용하여 UI커스텀


### Trouble Shooting
- STEP1
    - 새롭게 추가되는 연락처의 중복확인을 위해서, 연락처의 이름,나이,전화번호 3가지를 모두 비교할것이냐, 각 연락처에 특정 ID값을 부여해서 중복을 확인할것이냐에 대한 고민을 많이 했었는데, 잘 알지 못하는 개념인 UUID를 사용해서 진행하는것 보다 확실하게 아는 방법으로 코드를 만드는게 옳은 방법이라 생각해, 전체를 비교하는 for문을 통해서 중복값을 확인하도록 하였다. 
- STEP2
    - 연락처 추가를 위한 페이지 이동 방식중 NavigationController를 사용할지, present를 통해서 호출할지에 대한 고민 → 연락처 추가의 경우는 단발성 이벤트 이기에 present로 Modal로 여는게 맞다는 생각이 들어서 present로 진행함. 
    - UITextFieldDelegate 사용이 옳은것인가? 이름, 나이는 사실 입력 후 Save 버튼을 유저가 눌렸을때만 검사를 진행하면 되는데, 하이픈을 넣기 위해서 현재 입력중인 이벤트를 계속해서 받아올 방법에 대해서 고민했음. UITextFieldDelegate 프로토콜을 사용하면 별도의 로직을 구현하지 않더라도 사용이 가능했지만, 우리가 사용하는 기능이 꼭 프로토콜을 사용해야만 하는가에 대한 의문이 들었으나 프로토콜에 대해 공부도 할겸, 사용하는 방향으로 정해서 적용시켰다. 이후에 addTarget함수에 대해서도 배울 수 있었다. 
    - 새 연락처를 추가하는 과정에서, 이름,나이,연락처의 유효성 검증을 순차적으로 진행해야 하기 때문에, do try~catch문을 사용하여 해결하였다. 
- STEP3
    - Dynamic type의 적용이 제대로 이루어 지지 않는 문제가 발생하였는데, Autolayout 의 trailing 값이 적용되지 않은것을 발견하여 해결할 수 있었다. 보통 Autolayout에서 문제가 생기면 스토리보드에서 에러가 뜨는데, 이번 케이스의 경우에는 별다른 에러가 발생하지 않아서 모든 UI들을 하나하나씩 점검해보는 방법으로 찾을 수 있었다. 
    - searchBar를 사용할지 searchController를 사용할지 고민하였다. 최종적으로는 두 방식의 큰 차이점을 인지할 수 없어서, searchController를 사용함 -> 이 문제는 추후에 두가지 방식의 차이점이 뭔지, 어떤게 좋은방법인지 명확하게 공부를 통해서 확인해야 할 것 같다.  


### 느낀점
- Howard: 이번 프로젝트를 진행하면서, 사용하는 기술들에 대해 정확히 왜 사용해야하고 어떻게 동작하는지 원리를 파악하는것에 중점을 두면서 진행했던것 같다. 특히 데이터를 직접적으로 관리하는 객체의 타입과, Delegate의 구체적인 원리 및 사용법, 그리고 함수,프로토콜등의 네이밍을 어떻게 해야되는지에 대해 배운게 큰 소득이었던 것 같다.
모델의 타입을 struct,class 중에 많이 고민했었는데, 최초에는 여러 화면에서 데이터에 대한 관리와 조작이 필요할 것이라 생각들어 여러 컨트롤러에서 객체를 주입하고 사용하는게 reference counting을 발생시키고, 성능상에 좋을 것 같지 않아서 struct로 진행하였으나, 오히려 여러 화면에서 데이터 변경시 어느 화면에서는 변경이 되고 어느 화면에서는 변경이 안되는 상황이 발생할 수 도 있다는 점에서 class로 사용하는게 더 낫지 않냐는 리뷰어의 조언에 어떤 상황에서 어떤 타입을 써야될지에 대해 많이 고찰할 수 있었던 시간이 되었던 것 같다. 
이전 프로젝트에서도 VC에서 화면전환을 할 때, 데이터를 전달하기 위해서 delegate를 사용하였는데, '위임'이라는 의미를 이해하지 못한채, 마냥 화면전환시 데이터 전환을 위한 프로토콜 또는 방법이라고만 생각하고 사용했었던 것 같다. 어떤의미에서는 B에서 A로 데이터를 전달해주는것처럼 보일 수 있지만, 원래라면 B에서 처리해야될 어떤 일을, A에게 시켜서 대신 처리하게끔 A에게 권한을 주는 방식이다. 왜 굳이 이렇게 하냐면 A가 이미 B가 수행해야될 기능을 가지고 있으니, 굳이 B에 그 기능을 또 만들어서 처리하지 않고, 쉽게 A를 불러서 A가 대신 B의 일을 처리하게 해주는 것이었다. 왜 delegate를 사용하고, 어떻게 동작하는지에 대한 원리를 알 수 있어서 좋았다. <br>

- Mond: 이번 프로젝트에서 가장 중점적으로 배운 점은 네이밍이다. 항상 네이밍을 작성할 때는 나중에 바꿔야지 하는 생각으로 크게 생각하지 않고 작성했었는데 네이밍을 보고 그 함수나 변수가 무슨 일을 하는지 어떤 것을 return 하는 지를 알 수 있도록 작성해야 한다는 것을 배웠다. 
또한 delegate에 대해서도 더 자세히 배웠다. 저번 프로젝트에서도 사용했었는데 그 때는 다른 화면으로 데이터를 전송하기 위한 것! 이라고 이해했다. delegate의 개념을 이해하는 것 보다는 링크를 보고 코드를 이해하는데 시간을 많이 쏟았었는데 이번에는 delegate의 개념이 어떤 것이고 왜 사용했는지에 대해 더 집중적으로 생각했다. delegate는 데이터를 전송하는 개념이 아닌 해야할 일을 넘겨주는 위임자와 대신 일을 해주는 대리자로 이루어져 있다. 사용하는 가장 큰 이유는 의존성을 낮추기 위해서이다. 의존성이 낮아지는 이유는 model이 위임하는 ViewController에 없기 때문에 쓸데없는 인스턴스를 생성할 필요가 없어지기 때문이다. 또한 delegate는 객체 간의 작업이라서 참조 값을 사용하기 때문에 retain 현상이 일어난다. 이 메모리 누수를 해결하기 위해서는 `weak (+AnyObject)`을 사용해야한다는 것을 알게되었다.
위에 말한대로 배운 점도 많지만 많은 것들을 고민하기도 했었는데 model에 struct, class 중에 어떤 것을 사용할지, navigation controller, navigation bar 중 무엇을 사용할지, searchController, searchBar 중 무엇을 사용할지 등 같은 기능들 중 어떤 것을 사용할지에 대해 많이 고민했다. 같은 기능이여도 서로 다른 점이 있기 때문에 상황에 맞춰 사용할려고 많이 고민했다. 그리고 적혀있지 않는 기능에 대해 넣을지 말지에 대한 고민도 많이 했다. (예를 들어 중복체크, 정렬)


### 프로젝트 진행 중 참고한 링크
- 참고해야하는 문서
    - [Configuring a new target in your project](https://developer.apple.com/documentation/xcode/configuring-a-new-target-in-your-project)
    - [UITableView](https://developer.apple.com/documentation/uikit/uitableview)
    - [Table views](https://developer.apple.com/documentation/uikit/views_and_controls/table_views)
    - [Filling a table with data](https://developer.apple.com/documentation/uikit/views_and_controls/table_views/filling_a_table_with_data)
    - [Table View Programming Guide for iOS](https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/TableView_iPhone/TableViewStyles/TableViewCharacteristics.html#//apple_ref/doc/uid/TP40007451-CH3-SW1)
    - [UIAlertController](https://developer.apple.com/documentation/uikit/uialertcontroller)
    - [Auto Layout Guide](https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/index.html#//apple_ref/doc/uid/TP40010853-CH7-SW1)

- Table View
    - [[iOS]TableView 이용해 화면에 목록 표시하기](https://dblog.tech/34)
    - [[iOS]TableView의 변화를 처리하는 방법](https://snowee.tistory.com/47) 
    - [[iOS]UITableView 와 Custom UITableViewCell 적용 하기](https://velog.io/@dlskawns96/UITableView-%EC%99%80-Custom-UITableViewCell-%EC%A0%81%EC%9A%A9-%ED%95%98%EA%B8%B0-Swift)
    - [[iOS]TableView cell 삭제하기](https://m.blog.naver.com/PostView.naver?blogId=soojin_2604&logNo=222405395193&categoryNo=64&proxyReferer=)

- STEP2 연락처 조건
    - [[iOS]String에서 특정 문자 제거](https://zeddios.tistory.com/196) 
    - [[iOS]String insert 사용하기](https://m.blog.naver.com/traeumen927/222036046625) 
    - [[iOS]UITextField](https://ios-development.tistory.com/257) 
    - [Add `-` Hyphen](https://stackoverflow.com/questions/37571247/how-to-add-hyphens-in-uitextfield-ios-swift) 
    - [[iOS]UITextField 글자 수 제한, 백스페이스 처리](https://velog.io/@leedool3003/iOS-UITextField-%EA%B8%80%EC%9E%90-%EC%88%98-%EC%A0%9C%ED%95%9C-%EB%B0%B1%EC%8A%A4%ED%8E%98%EC%9D%B4%EC%8A%A4-%EC%B2%98%EB%A6%AC)

- 기타
    - [[iOS]UML](https://sabarada.tistory.com/72)
    - [delegate 메모리 누수 해결을 위해 weak 키워드 추가](https://stackoverflow.com/questions/33471858/swift-protocol-error-weak-cannot-be-applied-to-non-class-type)
    - [[iOS]Dynamic Type](https://velog.io/@minni/Dynamic-Type-egjn26z5)
    - [[iOS]UISearchController](https://zeddios.tistory.com/1199)
