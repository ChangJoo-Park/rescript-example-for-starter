# Rescript React Super Rentals from Ember.js tutorial

Ember.js 의 튜토리얼 프로젝트인 [Super Rentals](https://ember-super-rentals.netlify.app/) 를 rescript-react로 작성한 프로젝트입니다.

위 프로젝트에서 구현한 부분입니다.

- Home 페이지
- About 페이지
- Contact 페이지
- RentalDetail 페이지


## Home페이지

Home 페이지는 상단에 Header와 Hero영역, 검색 그리고 목록을 가지고 있습니다.

최초에 검색어가 없는 경우에는 서버에서 가져온 데이터를 그대로 보여줍니다.
검색어를 입력하면 rental 타입의 title과 검색어를 소문자로 변환하여 포함하는 키워드이면 필터해서 보여줍니다.

## About, Contact 페이지

정적인 소개/연락처를 보여주는 페이지입니다.
About과 Contact 페이지는 서로 버튼을 통해 이동할 수 있습니다.

## API를 통해 받은 데이터를 type을 가지는 let-binding(?) 으로 만드는 방법

API 서버를 따로 만들지 않고 public 디렉터리에 `rentals.json` 파일을 만든 다음 HTTP 요청을 통해 가져오도록 구성했습니다.
`yarn start` 를 이용하여 시작한 다음 `/rentals.json` 으로 접근할 수 있습니다.

Rescript 포럼에서 [bs-fetch 대신 XMLHTTPRequest 를 사용하는 것을 권장한다](https://forum.rescript-lang.org/t/how-do-i-perform-http-requests/251/13) 라고 하지만, 이 프로젝트에서는 rescript 에 익숙해지는 것이 더 중요하므로 [bs-fetch](https://github.com/reasonml-community/bs-fetch) 와 [bs-json](https://github.com/glennsl/bs-json) 을 사용합니다.

bs-fetch는 HTTP 요청을, bs-json은 JSON을 파싱하기 위한 도구로 사용합니다.

아래와 같이 JSON.parse 를 사용하는 방식도 있으나, `@scope`, `external` 또한 이 프로젝트의 범위에 포함하지 않았습니다.

```bucklescript
@scope("JSON") @val
external parseResponse: response => {"message": array<string>} = "parse"
```



### API 응답이 객체인 경우

이 프로젝트에서 사용하는 rentals.json 파일은 API 응답이 객체가 아닌 배열입니다. 때문에 아래 예제를 통해 바로 `array<rental>` 타입을 가지는 let-binding 으로 만들 수 없었습니다.

아래 내용은 객체 응답을 변환하는 방법입니다.
URL `https://aws.random.cat/meow` 을 요청하면 아래와 같은 결과를 받을 수 있습니다.

```json
{
  "file": "https://purr.objects-us-east-1.dream.io/i/w8V75.jpg"
}
```

응답이 위와 같으므로 동일하게 타입을 만들어 줍니다.

```rescript
type catData = { file: string }
```

API 응답을 통해 만든 JSON 결과를 rescript 용 데이터로 변환하기 위한 디코더 모듈을 만듭니다

```
module Decode = {
  open Json.Decode // bs-json
  let catData = (data: Js.Json.t) => {
    file: field("file", string, data),
  }
}
```

이제 bs-fetch를 이용해 요청한 다음 데이터를 가공해야합니다.

```
let fetchCat = () =>
  Fetch.fetch("https://aws.random.cat/meow")
  ->Js.Promise.then_(Fetch.Response.json, _)
  ->Js.Promise.then_(obj => obj->Decode.catData->Js.Promise.resolve, _)

let _ = fetchCat()->Js.Promise.then_(data => data.file->Js.log->Js.Promise.resolve, _)
```


참고 : https://kevanstannard.github.io/rescript-blog/fetch-json.html

rescript react와 함께 사용하는 경우에 타입때문에 약간은 고생한 부분이 있습니다

API를 이용해 데이터를 가져와야하는 경우에 최초 상태가 None 일 수 밖에 없습니다.
이 경우에 rental에 타입을 명시적으로 지정하면 괴로워집니다. `type option<rental>` 과 `type rental` 사이에서 계속 문제를 일으킵니다.
때문에 useState를 쓸떄는 명시적으로 타입을 지정하지 않고, 나중에 패턴매칭을 이용합니다.

```
let (rental, setRental) = useState(() => None)
```



### API 응답이 배열인 경우

`rentals.json` 을 rescript let-binding으로 만들기 위해서는 다음 과정을 추가로 해야합니다

아래는 rentals.json 의 일부입니다.

```json
[
  {
    "type": "rentals",
    "id": "grand-old-mansion",
    "title": "Grand Old Mansion",
    "owner": "Veruca Salt",
    "city": "San Francisco",
    "location": {
      "lat": 37.7749,
      "lng": -122.4194
    },
    "category": "Estate",
    "bedrooms": 15,
    "image": "https://upload.wikimedia.org/wikipedia/commons/c/cb/Crane_estate_(5).jpg",
    "description": "This grand old mansion sits on over 100 acres of rolling hills and dense redwood forests."
  },
  // ...
]
```

우선 Fetch.fetch 의 결과를 json으로 만든 결과가 array인지 아닌지를 판별해야합니다.
위 객체 변환 예제와 같이 객체를 변환하기 전에 [Js.Json.classify](https://rescript-lang.org/docs/manual/latest/api/js/json#classify)를 이용해 JSONArray 패턴에 대응해야합니다.

```
module Decode = {
  open Json.Decode

  let rentalsData = data => {
    switch Js.Json.classify(data) {
    | Js.Json.JSONArray(data) => []
    | _ => []
    }
  }
}
```


Js.Json.classify의 결과는 [tagged_t](https://rescript-lang.org/docs/manual/latest/api/js/json#classify) 입니다. tagged_t 의 variant에는 JSONArray 가 있습니다.
패턴 매칭의 결과가 JSONArray variant 인 경우에 객체 변환과 동일하게 작업합니다.


```
module Decode = {
  open Json.Decode

  let rentalsData = data => {
    switch Js.Json.classify(data) {
    | Js.Json.JSONArray(data) => Js.Array.map(rental => {
        title: field("title", string, rental),
        owner: field("owner", string, rental),
        city: field("city", string, rental),
        category: field("category", string, rental),
        bedrooms: field("bedrooms", int, rental),
        image: field("image", string, rental),
        description: field("description", string, rental),
      }, data)
    | _ => []
    }
  }
}
```

JSONArray인 경우, data는 Array 타입이므로 map을 이용할 수 있습니다. map과 Json.Decode의 field를 이용해 type rental 에 포함된 내용을 모두 변환합니다.

이제 Decode.rentalsData 에 rental 타입 엘리먼트를 가지는 배열이 들어온다면 rescript에서 사용할 수 있는 `array<rental>` 타입 let-binding을 할 수 있습니다.

Fetch를 이용하는 전체 코드입니다.

```
Fetch.fetch("/rentals.json") // API 요청
// json 데이터로 변환
->Js.Promise.then_(Fetch.Response.json, _)
// json 을 array<rental> 로 변환
->Js.Promise.then_(obj => obj->Decode.rentalsData->Js.Promise.resolve, _)
// 사용
->Js.Promise.then_(json =>
  {
    setRentals(_ => json)
    json
  }->Js.Promise.resolve
, _)
```
