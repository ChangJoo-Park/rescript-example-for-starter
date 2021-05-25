# 자바스크립트 모듈에 접근하는 방법

rescript는 순수 자바스크립트와 자바스크립트 모듈과 통신할 수 있습니다. rescript에서는 interop 이라고 부릅니다.

이 예제는 interop 중 내부 ESModule를 가져와 사용하는 방법과 외부 라이브러리(여기서는 lodash)를 가져와 사용하는 방법을 다룹니다.

## 내부 모듈에 접근하는 방법

단순한 두 값의 합을 더하는 모듈을 만들고 rescript 소스 코드에서 사용합니다.

```js
export const sum = (a, b) => a + b
```

`sum` 모듈의 전체 코드입니다. 이 코드를 rescript 에서 가져와 사용하려면 다음과 같이 합니다.

```reason
@module("./modules/sum.js")
external sumFromModule: (int, int) => int = "sum"
```

각 파트를 살펴보면, `@module`은 모듈이 있는 경로를 지정합니다. 이 예제에는 상대 경로 `./modules/sum.js` 를 사용했습니다.
`external` 키워드는 외부의 자바스크립트 값을 가져오기 위한 rescript의 기능입니다.

전체 구성은 다음과 같습니다.

```reason
@module(<경로>)
external <rescript에서 사용할 이름>: (<전달할 인자>) => <리턴 값> = <모듈 함수 이름>
```

전달할 인자 부분을 `(int, int)` 로 정한 것은 rescript 타입 시스템 지원을 받아 `sumFromModule` 함수에 int 만 전달하기 위함입니다.

만약 sum 모듈을 이용해서 두 문자열을 이어 붙이기 하려면 다음과 같이 합니다.

```reason
@module("./modules/sum.js")
external concatString: (string, string) => string = "sum"
```

코드에서 "let newString = concatString(`헬로 `, `월드`)" 와 같이 사용한다면 "헬로 월드" 문자열을 결과로 받을 수 있을 것 입니다.

## 외부 모듈에 접근하는 방법

자바스크립트 생태계는 npm 이라는 패키지 매니징 시스템을 사용할 수 있습니다. rescript에서도 물론 npm 패키지를 사용할 수 있습니다.

rescript는 [lodash](https://lodash.com/)에 있는 많은 기능들을 이미 가지고 있는 것으로 보입니다.
하지만 예제를 위해 `lodash` 를 가져와 사용하는 방법을 알아봅니다

모듈을 가져오는 방법은 위의 내부 모듈에 접근하는 방법과 같습니다. 다만 다른 점은 `@module` 의 경로에 lodash를 입력하면 됩니다.

```reason
@module("lodash")
external minFromLodash: array<int> => int = "min"
```

이렇게 만들면 lodash 모듈의 `min` 함수를 `minFromLodash` 로 가져와 rescript에서 사용할 수 있습니다.

```reason
let data = [-1, 0, 1, 2, 3, 4]
let mininum = minFromLodash(data)
```

`minimum` 은 lodash의 min 모듈을 통해 -1을 결과로 보여줍니다.

rescript 모듈 시스템의 아쉬운 점은 모듈의 jsdoc 등의 타입 힌트를 이용할 수 없는 것 입니다. 그래도 @module 로 가져올 때 원하는 규격을 지정할 수 있으므로 복잡한 타입을 지정할 필요가 없는 경우에는 문제가 적을 것 같습니다.


한국어 문서는 [이 문서](https://green-labs.github.io/rescript-in-korean/JavaScript-Interop)를 살펴보세요.
