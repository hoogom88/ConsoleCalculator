# ConsoleCalculator
## 실행 방법
프로젝트의 bin 폴더에서 `dart run console_calculator.dart [Operand] [Operation] [Operand]` 를 입력하여 실행할 수 있습니다. 
`$ git clone https://github.com/hoogom88/ConsoleCalculator.git`  
`$ cd ConsoleCalculator`  
`$ dart pub get`  
`$ cd bin`  
`$ dart run console_calculator.dart [Operand] [Operation] [Operand]`  
### 실행 예시
![image](https://github.com/hoogom88/ConsoleCalculator/assets/67893559/140f0e0a-c899-4380-a30f-466f6d3387c4)



<br/>

## 설계 및 구조

### 상속과 구현의 관계를 나타낸 class diagram
<br/>

![diagram-7515475740708860016](https://github.com/hoogom88/ConsoleCalculator/assets/67893559/cae61044-ce3c-486d-b07f-ffe317e2f797)

<br/>


### 주요 클래스들에 대한 설명
- **Term** : 수식(다항식)에서 항을 나타내는 클래스
  - **Operand** : 수식의 항 중, 피연산자 상속 클래스
    - **Number** : 숫자로 이루어진 피연산자 상속 클래스
  - **Operation** : 수식의 항 중, 연산자를 나타내는 상속 클래스
    - **Addition** : 덧셈 연산을 제공하는 연산자 상속 클래스
    - **Subtraction** : 뺄셈 연산을 제공하는 연산자 상속 클래스
    - **Division** : 나눗셈 연산을 제공하는 연산자 상속 클래스
    - **Multiplication** : 곱셈 연산을 제공하는 연산자 상속 클래스

<br/>

- **Calculator** : 입력값에 대해 계산기(`calculate`) 기능을 제공하는 **퍼사드** 클래스
  - **BasicCalculator** : ExpressionOperator, Tokenizer, ExpressionValidator 클래스를 통해 계산 기능을 제공하는 구현 클래스

<br/>

- **Tokenizer** : 입력값을 각각의 항으로 **토큰화**(`tokenize`)를 수행 하는 클래스
  - **DefaultTokenizer** : 정규표현식과 문자열 탐색을 활용하여 토큰화를 수행하는 구현 클래스

<br/>

- **ExpressionValidator** : 토큰화된 다항식이 유효한 다항식인지 **검증**(`validate`)하는 클래스
  - **BasicExpressionValidator** : 토큰화된 다항식이 3개의 항으로 구성된 사칙연산 다항식인지 검증하는 구현 클래스

<br/>

- **ExpressionOperator** : 토큰화된 다항식의 결과값을 **계산**(`operate`)하는 클래스
  -  **PostExpressionOperator** : 토큰화된 다항식을 후위 계산 알고리즘을 통해 결과값을 계산하는 구현 클래스
  
<br/>

- **PrecedenceResolver** : 연산자의 우선순위를 제공하는 클래스
- **SimpleBusinessException** : 프로그램의 비즈니스 예외를 명시, 처리하는 클래스

<br/>

### 설계의 목적 및 의도
- 계산기의 기능을 **토큰화, 식 검증, 연산** 3가지의 행위로 분리하고 각각을 수행하는 객체를 만들었습니다.
- `Calculator` 객체가 각 세부 기능을 수행하는 객체를 합성하여, 계산기 기능을 제공하도록 하였습니다.
- 인터페이스를 통한 의존성 역전으로 토큰화, 식 검증, 연산 방식을 유연하게 변경 가능하도록 하였습니다.

- 다항식을 구성하는 항(`Term`)들을 연산자와 피연산자로 분리하고 공통 프로퍼티를 정의함으로써, 계산 과정에서 하위 구현체에 의존 없이 일괄 처리할 수 있도록 하였습니다.   
    - 다항식 연산에 후위 계산식(`PostExpressionOperator`)을 사용하여, 연산자 구분없이 연산에 필요한 피연산자의 개수만으로 연산이 처리되도록 하였습니다.
    - 또한 후위 표현식을 통한 계산 방식은 반복 탐색을 통한 우선 순위 계산 방식에 비해 나은 성능을 갖고 있습니다. (O(n) vs O(n * m), n: 항의 개수, m: 연산자의 종류)
- 피연산자(`Operand`) 추상 클래스를 상속하여 `Number` 피연산자를 만듬으로써, 추후 삼각함수를 위한 도(degree), 변수 등, 다양한 피연산자를 확장가능하도록 하였습니다.
    - 피연산자를 객체로 처리하는 것은 primitive 타입 연산에 비해 느리지만, 1000회의 연산에서 0.006초 차이로 입력 식의 길이가 제한되는 계산기에서 큰 영향을 주지 않는다고 판단하였습니다.
    - 또한, 토큰화 과정에서 한번의 분류 이후 연산과정에서 추가적인 분류 로직이 필요없기 때문에 실제 속도 차이는 더 작아진다고 판단하였습니다.
- 각각의 연산자를 하나의 연산자(`Operation`) 추상 클래스를 상속하게 함으로써, 계산 과정에서는 세부 구현체에 대해 의존 없이 계산이 가능하도록 만들었습니다.
    - 사칙연산 연산자 객체는 내부 데이터가 모두 동일하기 때문에 Singleton 패턴으로 구현하였습니다.
    
- 또한, 추후 삼각함수, 적분, 미분, 로그, 괄호 등의 추가 기능을 확장할 수 있습니다.
- 연산자 우선순위(`PrecedenceResolver`)의 경우 계산 방식, 지원 기능에 관계 없이 항상 동일하기 때문에, 변경이나 확장이 없을 것이라고 판단하였습니다.
- 계산기에서 발생할 수 있는 예외 상황에 대해 `SimpleBusinessException` 객체를 발생시키도록 하여, 최상위 함수에서 일괄된 예외처리가 가능하도로 하였습니다.

<br/>

## 개발
- **테스트 주도 설계(TDD) 방식**으로 아래의 순서 반복으로 전체 프로젝트를 개발하였습니다.
    - 인터페이스 및 최소한의 뼈대 클래스 작성
    - 테스트 코드 작성 (실패)
    - 테스트 코드를 통과할 수 있는 로직 작성
    - (로직에 대한 검증이 필요한 경우 추가 테스트 코드 작성)
    - (인터페이스 혹은 설계를 수정해야하는 경우 다시 처음으로)
    - 테스트 코드 통과
- TDD의 개발 흐름을 확인할 수 있도록 커밋을 세분화하고 커멧 메시지가 흐름을 나타내도록 작성하였습니다.

- 본 프로젝트는 펌웨어이며, 외부 데이터 요청, 저장 및 데이터 전달의 흐름이 없기 때문에 **주요 기능을 제공하는 객체**를 기준으로 Directory를 분리하였습니다.
- 본 프로젝트는 과제이기 때문에 Github에서 타입을 확인할 수 있도록 `final` 키워드에도 타입을 명시하였습니다.

<br/>

## 기타
- 입력과 출력에 대한 길이 제한이 주어지지 않아, 임의로 제한하였습니다.  
    (소수점을 포함한 최대 14자리)

## 아쉬운점
- Tokenizer, ExpressionValidator, ExpressionOperator 객체 생성 및 관리에 추상 팩토리 패턴을 적용하여 확장성을 향상시킬 수 있을 것 같습니다.
