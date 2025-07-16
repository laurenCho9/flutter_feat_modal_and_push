# flutter_feat_modal_and_push

버튼 클릭> 모달창이 아래에서 열리고> 프로필입력버튼 클릭> 우측에서 푸쉬(+페이지)로 등장(모달창의 데이터상태가 전역상태여야 한다.)

## ❓왜 모달위에서 페이지 이동(Navigator)이 일어났다가 메인페이지로 되돌아왔는데 모달열림과 해당 탭메뉴의 상태가 유지되고 있어? 리액트는 이렇게 구현하려면 무조건 전역상태관리zustand 등으로 처리해야 해.

`main.dart`, `modal.dart`, `profile_input.dart`

> 이 질문은 코드 변경하지말고 그냥 설명만 부탁해..!
> 나는 리액트를 하다 온 사람인데, 원래 리액트 기준으로 생각하면 모달에서 특정 페이지로 이동후 다시 닫기 버튼을 눌러 모달창이 뜬 페이지로 돌아왔을 때, 해당 탭메뉴 위치에 대한 값 등이 전역상태관리zustand 등을 써야 저장이 되는 구조였잖아.
> 근데 플러터는 riverpod을 쓴 것도 아닌데 어떻게 해당 탭메뉴 모달이 그대로 기억되어서 보여지고 있는 거야?
> 모달 위에 모달로 푸쉬해서 연 것도 아니고 모달 위에 푸쉬애니메이션을 통해 페이지 이동을 한 걸로 아는데?
> 이게 플러터가 정렬 방식이 x축 y축 z축까지 설정이 가능하다더니 그래서 그런 거야?
> 코드 짜여진 구조 분석 후 이게 어떤 원리로 이렇게 잘 화면이 유지되고 있는 건지 설명만 부탁할게(다시 말하지만 이번 질문은 코드 변경없이 설명만 부탁행!)

아주 좋은 질문입니다!  
리액트 개발자라면 자연스럽게 “전역 상태 관리 없이 어떻게 모달의 탭 상태가 유지되지?”라는 의문이 들 수 있습니다.  
Flutter(특히 StatefulWidget)와 네비게이션의 동작 원리를 이해하면 이 현상이 자연스럽게 설명됩니다.

---

## 1. **Flutter의 상태 보존 원리 (StatefulWidget)**

- **StatefulWidget**은 자신의 상태(`State`)를 인스턴스가 살아있는 동안 “메모리”에 보관합니다.
- Flutter에서 `Navigator.push`로 새로운 페이지를 띄우면,  
  **이전 페이지(여기서는 모달 CustomModal)는 메모리에서 사라지지 않고, 단지 “화면 밖”으로 밀려나 있을 뿐**입니다.
- 사용자가 푸쉬된 페이지에서 `pop()`을 호출하면,  
  **이전 페이지의 State 인스턴스가 그대로 복원**되어 다시 화면에 나타납니다.

### 즉,

- **CustomModal의 State 인스턴스(\_CustomModalState)**는  
  푸쉬된 페이지(profile_input.dart)가 열려 있는 동안에도 메모리에 남아 있습니다.
- 사용자가 profile_input.dart에서 돌아오면,  
  **CustomModal의 상태(예: \_selectedTab, tabCompleted 등)는 그대로 유지**됩니다.

---

## 2. **React와의 차이점**

- React(특히 SPA)에서는 페이지 이동 시 컴포넌트가 언마운트되면 상태가 사라집니다.
- 그래서 전역 상태(zustand, recoil, redux 등)가 필요합니다.
- Flutter는 **위젯 트리의 특정 부분만 교체**하고,  
  나머지 부분(StatefulWidget의 State)은 메모리에 남겨둡니다.

---

## 3. **Navigator의 동작 방식**

- Flutter의 `Navigator`는 **Stack 구조**입니다.
- `showModalBottomSheet`로 모달을 띄우면,  
  모달이 Navigator Stack의 맨 위에 올라갑니다.
- 모달에서 다시 `Navigator.push`로 새 페이지를 띄우면,  
  **모달 위에 새로운 페이지가 쌓입니다.**
- 이때, **아래에 있던 모달의 State는 그대로 보존**됩니다.

---

## 4. **Z축(Depth)과의 관계**

- Flutter는 위젯을 x, y, z축(Depth)으로 배치할 수 있지만,  
  이 현상은 z축 때문이 아니라 **Navigator의 Stack과 StatefulWidget의 State 보존** 덕분입니다.
- 즉, z축(예: Stack, Positioned, Material의 elevation 등)은  
  위젯의 시각적 레이어를 결정하지만,  
  **상태 보존은 Navigator와 StatefulWidget의 라이프사이클**에 의해 결정됩니다.

---

## 5. **정리**

- **전역 상태 관리 없이도**
  - “모달의 탭 상태”가 유지되는 이유는
  - **CustomModal의 State 인스턴스가 메모리에 살아있기 때문**입니다.
- **Navigator.push**로 새 페이지를 띄워도
  - 이전 페이지의 State는 사라지지 않고
  - pop()으로 돌아오면 그대로 복원됩니다.
- **React와 달리, Flutter는 StatefulWidget의 State가 위젯 인스턴스가 살아있는 한 유지**됩니다.

---

### 결론

**Flutter는 StatefulWidget의 State와 Navigator의 Stack 구조 덕분에,  
전역 상태 관리 없이도 “이전 화면의 상태”가 자연스럽게 보존됩니다!**

궁금한 점 더 있으면 언제든 질문해 주세요!
