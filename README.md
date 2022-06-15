# DidIDoMyBestToday

오늘의 나는 과연 열심히 살았을까?..

# To-do

### 주요 기능

- 오늘 하루 ToDo List
- 월간 제대로 살았는지... 확인해주기
- Github 처럼 

### CocoaPod

- SnapKit
- RealmSwift

### 진행 사항

- 06/15 기준
  - MainScene / WriteScene / ComposeScene 으로 구성
  - MainScene의 Presenter가 WriteScene / ComposeScene Presenter를 소유하고있고, Delegate 패턴을 통해 DataSteam 를 진행합니다.
  - Presenter간의 Delegate를 위한 공통 Protocol은 PostToMainProtocol 입니다.
  - 데이터는 RealmSwift를 사용하여 Persist하게 저장하고 있습니다.
  - RealmSwift의 Primary Key는 ID입니다.
  - ID 는, UserDefaults를 통해 관리 되고 있고, 특정 Task를 Realm에 저장 할 때 마다, +1 씩 카운팅 시켜서, Primary Key역할을 수행하게 했습니다.
  - Daily To-do List 작성 기능이 필수 기능인 만큼, **하루가 지났는지** 에 대한 여부가 중요합니다.
  - 날짜 지나는 부분에 대한 처리로 MainScene의 Presenter가 ```viewDidLoad``` 하는 시점에 ```NotificationCenter```을 통해 ```NSCalendarDayChanged```를 구독하여 처리했습니다.
  - ComposeScene / WriteScene 같은 경우 TableView의 Cell에 TextField / TextView를 담아서 작성 정보를 추출하는데, Cell(View) 단위의 MVP 패턴을 적용하여 작성한 데이터에 대한 부분을 각 Scene의 Presenter로 보낼수 있도록 구현했습니다.
