# Rescript React Router

`@rescript/react` 라이브러리에는 라우터가 포함되어 있습니다.
`RescriptReactRouter` 를 이용해 현재 URL의 path, hash, search 속성에 접근할 수 있습니다.

https://rescript-lang.org/docs/react/latest/router


```jsx
@react.component
let make = () => {
  let url = RescriptReactRouter.useUrl()

  <div className="container">
    <div className="body">
      {switch url.path {
      | list{"about"} => <AboutPage />
      | list{"users"} => <UsersPage />
      | list{"users", userId} => <UserDetailPage userId=userId />
      | list{} => <HomePage />
      | _ => <NotFoundPage />
      }}
    </div>
  </div>
}
```

각 페이지에서 다른 페이지 또는 라우트로 이동할 때 `<a></a>` 태그를 사용하면 해당 라우트로 이동은 하지만 모든 에셋을 새로 가져옵니다.

RescriptReactRouter 기능을 이용해 라우트를 변경하려면 아래 `<Link>` 컴포넌트를 사용해야합니다.

```jsx
// Link.res
let handleClick = (href, event) =>
  if !ReactEvent.Mouse.defaultPrevented(event) {
    ReactEvent.Mouse.preventDefault(event)

    RescriptReactRouter.push(href)
  }

@react.component
let make = (~href, ~className="", ~children) =>
  <a href className onClick={event => handleClick(href, event)}> children </a>
```

Link 컴포넌트는 a 태그와 사용법이 같으나 클릭을 하면 `RescriptReactRouter.push` 를 이용해 라우트를 변경합니다.
