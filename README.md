# ChattingApp
💬 Swift_ChattingApp (Feat. Firebase)

> 간단 설명: 실시간 채팅을 구현해 본 프로젝트
>
> 기한: 2020.10.10 ~ 2020.10.17 



## ✔️ 프로젝트 설명

Firebase 프로젝트에 iOS앱을 추가해 Authetication과 Firestore 서비스를 이용한 회원가입, 로그인, 로그아웃, 실시간 1대1 채팅을 구현해보고자 한 프로젝트입니다.

더 자세한 내용은 [wody의 개발일기](https://wodyios.tistory.com/4)에 작성해 두었습니다.



## 💬 결과 구현

### 메인 화면 + 회원가입 화면 + 로그인 화면

<img width="30%" src="https://user-images.githubusercontent.com/56102421/96287563-1b1e5200-101d-11eb-84a1-00a82778d008.gif" alt="" />

### 1대1 채팅 구현 

<img width="70%" src="https://user-images.githubusercontent.com/56102421/96286096-ce397c00-101a-11eb-8e6b-34bd1fbedfef.gif" alt="" />



## 📚 새롭게 알게 된 점

- **UITableViewCell vs Reusable Cell**

  TableView를 이용하면서 헷갈릴만한 두가지는 Reusable Cell과 UITableViewCell 였다. 두가지는 완전 다른 것이다! UITableViewCell로 선언된 파일은 그 Cell의 이름이고, Reusable Cell은 말 그래도, Cell을 재사용할 때 필요한 것이다. Cell을 재사용하려면 identifier을 줘서 재사용할 수 있도록 해주어야 한다. 즉, UITableViewCell을 Reusable Cell로 등록해서 계속 재사용할 수 있도록 만들어준다 이 뜻이다. 

- **xib을 이용하여 TableViewCell 뷰 짜고 등록하는 방법**

  <img src="https://user-images.githubusercontent.com/56102421/96285875-7b5fc480-101a-11eb-9c00-207142fba3d5.png" alt="" >

  위와 같이 xib 파일의 Cell에 Identifier를 부여한 후, TableView가 있는 VC로 돌아와 ViewDidLoad() 내에 cell을 등록한다.

  ```swift
  // cell 등록하기
  messageTableView.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
  ```

- **IQKeyboardManagerSwift 라이브러리** 

  키보드에 의하여 textfield가 가려지는 문제점에 대해 원래는 Notification을 이용하여 keyboard의 높이를 계산해 그 만큼 뷰를 올려주는 방식을 사용해 왔지만, 이 프로젝트에선 [***IQKeyboardManagerSwift***](https://github.com/hackiftekhar/IQKeyboardManager) 라는 pod를 이용하여 구현하였다. 

- **Seque Identifier을 이용한 뷰 이동**

  ```swift
  guard let dvc = self.storyboard?.instantiateViewController(identifier: "")
  ```

  위 코드처럼 다음 이동할 VC를 참조형태로 불러와 이동하는 방식을 주로 사용하였지만 이 프로젝트에선 Storyboard에서 연결 후 Seque에 identifier을 부여하여 이를 실행시키는 방식으로 구현하였다.

  ```swift
  self.performSegue(withIdentifier: "SignUp", sender: self)
  ```



## ❗️ 주의할 점

- `GoogleService-Info.plist`파일은 중요한 정보가 들어있는 파일이므로 `.gitignore`파일에 꼭 넣어주자! 

  이걸 모르고 Github에 프로젝트를 올리니까 GitGuardian에서 바로 Google KEY가 노출됐다고 메일이 날라왔다. 그래서 `gitignore`파일에 적용해주었지만 이전 커밋 이력이 남아서 이미 정보는 노출된 상태....ㅠㅠㅠ 그래서 다급히 파이어베이스 프로젝트에서 등록된 앱을 지웠다 ㅠ.. 다음엔 이런 실수 하지말자!!

  