# Project 03. 연락처 관리 앱

## 목차
> [1. Overview](#Overview)
>
> [2. Key Topics](#Key-Topics)
>
> [3. 프로그램 화면 예시](#프로그램-화면-예시)
>
> [4. 프로그램 설명](#프로그램-설명)
>
> [5. 회고](#회고)

## Overview
테이블뷰의 동작 과정과 활용을 학습하기 위해 연락처를 관리하는 앱을 구현해 보았습니다. 이 과정에서 백지 상태에서부터 프로젝트 초기 구성하기, 스토리보드 없이 programmatic 하게 구현하기, MVC 패턴에 대한 이해, delegate, dataSource, 의존성 주입 등의 키워드를 가지고 학습 및 적용해 보았습니다.


## Key Topics
- 테이블 뷰 활용하기
- 백지 상태에서 프로젝트 초기 구성하기
- 스토리보드 없이 프로젝트 구성하기
- MVC 패턴의 이해
- delegate, dataSource 패턴 학습
- 의존성 주입 학습
- Unicode 에 대한 이해
- 타입의 캡슐화/은닉화
- extension 활용하여 기본 타입에 커스텀 메서드 적용하기
- programmatic 한 오토레이아웃 적용해보기
- protocol 및 typealias 활용하기


## 프로그램 화면 예시

### 초기 화면
![스크린샷 2024-01-19 오후 4 55 44](https://github.com/eensungkim/ios-contact-manager-ui/assets/73898006/eb50be49-d29d-4dfb-ad3b-7edcba8c9602)

### 새 연락처 추가 화면
![스크린샷 2024-01-19 오후 4 50 15](https://github.com/eensungkim/ios-contact-manager-ui/assets/73898006/ecb98bc7-cb0c-4e39-8859-f159bde092dc)

### 취소 버튼 알럿
![스크린샷 2024-01-19 오후 4 50 20](https://github.com/eensungkim/ios-contact-manager-ui/assets/73898006/fb6fae39-968f-4773-bf0c-f7ef5d9e8d03)

### 유효성 검사 알럿
![스크린샷 2024-01-19 오후 4 50 42](https://github.com/eensungkim/ios-contact-manager-ui/assets/73898006/31b829e6-38bb-498f-b7d1-1ba4d494562a)

### 초성 검색
![스크린샷 2024-01-19 오후 4 50 55](https://github.com/eensungkim/ios-contact-manager-ui/assets/73898006/4208f95f-f955-4d88-b7eb-bdf3eb37318e)

### 단어 일부로 검색
![스크린샷 2024-01-19 오후 4 58 05](https://github.com/eensungkim/ios-contact-manager-ui/assets/73898006/74814675-23e2-4040-96ea-ece1bcb33ce9)

### 셀 스와이프 삭제 기능
![스크린샷 2024-01-19 오후 4 51 12](https://github.com/eensungkim/ios-contact-manager-ui/assets/73898006/4381cc94-7905-47ad-b399-0db19ff38552)

### 셀 선택 시 정보 연동 기능
![스크린샷 2024-01-19 오후 4 58 05](https://github.com/eensungkim/ios-contact-manager-ui/assets/73898006/d41ce257-a2d5-41ee-adb1-a392916b6b91)


## 프로그램 설명
### Class Diagram
![연락처관리앱 drawio](https://github.com/eensungkim/ios-contact-manager-ui/assets/73898006/be1fc02d-3653-48f3-89a0-5379631dfe66)

### Model
**Contact.swift**
- Contact 구조체
    - property : 이름, 전화번호, 나이

**Contacts.swift**
- Contacts 모델 클래스
    - property: 기초데이터, 정렬배열
    - method: 정렬된 연락처 반환, Contact 정렬, 필터링, 배열, 추가, 삭제, 변경, JSON 파일 로드

**ContactsProtocol.swift**
- delegation 을 위한 프로토콜

### View
**ContactsTableView.swift**
- 연락처 테이블 뷰 클래스

**ContactsAdditionModalView.swift**
- 연락처 추가 모달 화면 뷰 클래스

**ContactsNavigationBar.swift**
- 연락처 리스트 화면 내비게이션 바 뷰 클래스

**ContactsTableViewCell.swift**
- 연락처 테이블 뷰 셀 커스텀 클래스

### Controller
**ContactListViewController.swift**
- 연락처 뷰 컨트롤러
- ContactsApproachable 로 정렬된 연락처 받아오는 기능 위임받음

**ContactsAdditionModalViewController.swift**
- 새 연락처 뷰 컨트롤러
- ContactsManageable 로 연락처 추가/변경/삭제 기능 위임받음
- 유효성 검사 메서드

**UIViewControllerExtension.swift**
- 알럿 기능


## 회고
공식 문서에 익숙해지고 UIKit 에 빈번하게 나타나는 여러 패턴들에 익숙해졌다는 점이 이번 프로젝트를 통해 얻은 가장 큰 수확 중 하나입니다. 모르는 내용이 나오더라도 검색을 통해 키워드르 얻고 공식 문서를 확인하여 해결할 수 있을 것이라는 자신감을 작게나마 얻게 되었습니다.
MVC 패턴이라든가 의존성 주입, 책임과 역할의 분배 등 개발 철학에 관련한 부분들에 대해서도 여러 인사이트를 얻을 수 있었습니다. 앞으로 해당 키워드들에 대한 더 깊은 공부를 통해, 트레이드오프가 필요한 상황에서 근거를 가지고 의견을 교환할 수 있도록 성장하고자 합니다.
