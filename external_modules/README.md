# 외부 모듈 접근

rescript의 각 파일은 그 자체로 모듈이기 때문에 해당 모듈 외부에서 접근하려면 `{모듈이름}.{타입}` 과 같이 사용합니다.

```rescript
type location = {
  lat: float,
  lng: float,
}

type category = Estate | Condo | Apartment

type rental = {
  id: string,
  title: string,
  category: category,
  owner: string,
  city: string,
  location: location,
  bedrooms: int,
  image: string,
  description: string,
}
```

## 사용법

위와 같은 타입이 [Rental.res](/src/Rental.res) 파일 안에 있다는 다른 파일에서 Rental.{타입} 과 같이 접근할 수 있습니다.

예를 들어 타입 "rental" 에 접근하려면 `Rental.rental` 과 같이 사용합니다.
특이한 점은 category 타입으로 사용할 수 있는 Estate, Condo, Apartment는 각각 Rental.Estate, Rental.Condo, Rental.Apartment 으로 접근합니다.
`Rental.category.Estate` 는 접근할 수 없고 `Rental.Estate` 로만 접근이 가능합니다.
동일한 Estate를 `let otherCategory = Estate` 에 선언하더라도 같습니다.

이렇게 선언하여도 문제가 없는 이유는 `rental` 타입의 let 바인딩을 하는 경우 빌드 타임에 category의 Variant인지 자동으로 판단하는 것으로 보입니다.

## 빌드 결과

rescript는 정적 let 바인딩의 경우 빌드 타임에 판단하여 이미 결과를 넣어둡니다.

[Index.res의 `getDynamicCategoryMessage` 메소드](/src/Index.res#L46)는 외부로부터 rental 을 받아 런타임에 결과를 확인합니다.
이 경우에는 예상대로 JavaScript의 switch 문으로 변환됩니다.

```js
function getDynamicCategoryMessage(rental) {
  switch (rental.category) {
    case /* Estate */ 0:
      return "This is Estate";
    case /* Condo */ 1:
      return "This is Condo";
    case /* Apartment */ 2:
      return "This Apartment";
  }
}
```

그러나 [Index.res의 `staticCategoryMessage` 바인딩](/src/Index.res#L54)은ㄷ 빌드 타임에 이미 `This is Apartment` 로 값이 들어가있습니다.

```js
var staticCategoryMessage = "This is Apartment";
```

---

## 타입만 가진 모듈의 JavaScript 변환

타입 파일은 `Rental.bs.js` 로 빌드가 되면 빈 파일입니다. 순수 자바스크립트에는 타입이 없기 때문으로 보입니다.
