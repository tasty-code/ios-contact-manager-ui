# ios-cantact-manager

----

<a href ="#1-Step1---사용자 입력 수신 및 검증">Step1 - 사용자 입력 수신 및 검증</a>

<a href ="#2-Step2---사용자 메뉴 표기">Step2 - 사용자 메뉴 표기</a>

<a href ="#3-Step3---목록/검색 기능 구현">Step3 - 목록/검색 기능 구현</a>

----
## 프로젝트 파일 구조
<img src="https://user-images.githubusercontent.com/71758542/210035621-ba5e2146-cc9a-416f-93ab-ed3f77235cba.png" width="1000">

---
## 역할 분배
|struct/class|역할|
|:---|:---|
|`ContactManager`|- 프로그램이 실행될 때 가장 먼저 수행되는 부분</br>- startProcess를 사용하여 메뉴가 실행되도록 하며, 메서드 내의 반복문을 통해 한 가지 기능을 수행한 후 다시 메뉴 선택 화면을 보여줄 수 있도록 한다.
|`ContactInformation`|- ContactInformation을 사용하여 사용자로부터 입력받은 정보들을 구조화하여 저장할 수 있도록 하였다.|
|`Converter`|- string <-> [Character]의 변환을 수행한다.|
|`Detector`|- 공백문자를 제거하는 역할을 수행한다.|
|`Checker`|- 사용자로부터 입력된 연락처가 주어진 제약사항에 위배되는지를 확인한다.|

|enum|역할|
|:---|:---|
|`PrintMessage`|- 메뉴, 오류 메세지 등 메세지 출력을 관장하는 부분이다.</br>- validUserInput, searchContact를 타입 메서드로 선언하여 별도의 인스턴스 생성 없이 외부에서 사용할 수 있도록 구현하였다.|
|`RegularExpression`|- Checker에서 사용자 입력 확인 시 필요한 정규식을 담고 있다.|

|protocol|역할|
|:---|:---|
|`InputPossible`|- 해당 프로토콜을 채택하는 경우 입력의 기능을 수행할 수 있도록 하였다.|
|`SystemMenuWorkable`|- 해당 프로토콜을 채택하는 경우 시스템 메뉴의 구성요소를 모두 수행할 수 있도록 하였다.|
---

## Step1 - 사용자 입력 수신 및 검증
[PR #2 | Step1 - 사용자 입력 수신 및 검증](https://github.com/tasty-code/ios-contact-manager/pull/2)

- 사용자 입력 형태 검증
- 이름, 나이, 연락처 구분
- 정규식

사용자의 연락처 정보 입력을 수신 받아 정규식을 통해 입력값을 검증하여 Console 화면에 출력하는 단계로    
입력 순서는 이름, 나이, 연락처로 구분되어지며 각 항목의 조건으로는 아래와 같다.
1. 이름: 띄어쓰기를 구분하지 않으며 특수문자 및 숫자 그리고 영문이름만 사용할 수 있다.
2. 나이: 세자리 수 이하로만 사용할 수 있다.
3. 연락처: 앞 자리는 지역 번호 및 핸드폰(010) 번호만 사용 가능하도록 2~3자리 수만 사용할 수 있으며    
    연락처의 기본 형식을 따라 `-`를 2개 사용하여 분리하여 입력하는 것만 사용할 수 있다.
    
### 적용해보려고 노력해본 점
최대한 객체화를 해보려고 노력하였다. 하여 위 표를 확인하면 `struct/class`의 Custom Type으로    
문자와 문자열의 타입을 변환해주는 역할만 할 수 있는 `Converter`, Space(_) 값을 검출해내는 역할만 할 수 있는 `Dectector`, 정규식 표현과 일치하여 검출하는 역할만 하는 `Checker`를 객체화를 시도해보았다.   
또한 프로토콜을 사용하여 `InputPossible`과 `SystemMenuWorkable` 프로토콜을 준수하게끔 하여    
해당 기능을 구현할 수 있도록 하였다.

## Step2 - 사용자 메뉴 표기
[PR #13 | Step2 - 사용자 메뉴 표기](https://github.com/tasty-code/ios-contact-manager/pull/13)

- 프로그램 종료 기능 구현
- 반복문을 통한 프로그램 재실행

사용자의 메뉴 선택 입력을 받아 시스템 메뉴 구성에 맞춰 분기하여 일을 수행할 수 있도록 관리하는
ContactManager를 업데이트 하였으며 검색을 원하는 이름값을 사용자에게 입력받아 `filter`    
고차함수를 사용하여 처리하도록 구현하였다.

## Step3 - 목록/검색 기능 구현
- 중복된 데이터는 저장되지 않도록 구현
- 이름으로 연락처 검색

앞서 선택할 수 있도록 제공된 메뉴 중 연락처 목록보기 기능과 사용자로부터 검색할 이름으로 검색할    
이름을 입력받아 검색할 수 있는 기능을 구현하는 단계이다.

**[연락처 목록보기]**
1. 프로그램 실행 시 `2`를 입력하여 연락처 목록 메뉴를 선택한다.
2. `- 이름 / 나이 / 연락처` 형식으로 연락처 목록을 출력한다.

**[연락처 검색]**
1. 프로그램 실행 시 `3`을 입력하여 연락처 검색 메뉴를 선택한다.
2. 사용자로부터 검색할 이름을 입력받는다.
3. 이름이 일치하는 연락처를 `- 이름 / 나이 / 연락처` 형식으로 출력한다.    
    이름이 중복되는 경우 함꼐 출력한다.
    
기존에 연락처를 저장하던 방식은 Custom type `ContactInformation`을 요소로 갖는 Array Type   
이었으나, Set Type으로 변경하여 사용하였다. Set을 사용하면서 Dictionary와 같이 Key 값을 가지는   
`Hashable`한 기본 타입이 아닌 Custom type을 사용하면 `Hashable 하지 않기 때문에` ContactInformation에 Hashable을 채택하여 해결하였다.
타입을 변경하면서 느낀점은 다음과 같다.

1. `Array`에서 요소를 추가할 때 `append`를 사용하였으나 `Set`의 경우 `insert`로 값을 추가한다.
2. 값을 추가할 때 `Array`의 경우 중복된 값을 추가하더라도 문제 없이 추가되지만    
    `Set`의 경우 `insert`로 요소를 추가할 때 중복된 값이 있으면 추가하지 않는다.
3. 연락처 목록 출력 시 중복된 값은 출력되지 않아야 하므로 중복값을 아예 넣지 않거나    
    제거했어야 했는데, `Set`을 사용하여 중복값 제거의 과정을 별도로 수행하지 않아서 효율적이다.

## 순서도
<img src="https://user-images.githubusercontent.com/71758542/210042473-17ae81e9-4f11-45f5-9462-49b596420b71.png" width="1000">

### 연락처 추가 출력 화면
<img src="https://user-images.githubusercontent.com/92699723/210034468-700b70ea-796b-4dac-b741-182cc6dc6d57.png" width="455">

### 연락처 목록보기 출력 화면
<img src="https://user-images.githubusercontent.com/92699723/210034466-6b26de10-4165-4e54-a9a6-4a9ed14acbf4.png" width="419" >


### 연락처 검색 출력 화면
<img src="https://user-images.githubusercontent.com/92699723/210034464-de2babaa-e26f-4f5f-b5e2-5b25a5917475.png" width="422">