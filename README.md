# 처음 시작하는 사람을 위한 rescript 프로젝트

> 주의 : 이 프로젝트는 rescript 전문 개발자가 만든 프로젝트가 아닙니다.
>
> 안티패턴으로 작성된 코드가 있을 수 있습니다.
>
> 발견하시면 Pull Request 부탁드립니다.

## 소개

이 저장소의 프로젝트 내용입니다. 각 디렉터리안에서 프로젝트를 실행해보세요

1. [hello_world](/hello_world) : rescript + react 를 이용해서 브라우저에 Hello World 를 출력합니다.
1. [unicode_react](/unicode_react) : rescript + react 에서 CJK 출력은 백틱 (`) 을 사용하세요.
1. [rescript_react_router](/rescript_react_router) : rescript + react 를 이용해 클라이언트사이드 라우팅을 구현합니다.
1. [counter](/counter) : rescript + react 를 이용한 간단한 카운터입니다.
1. [simple_todo](/simple_todo) : rescript + react 를 이용한 간단한 Todo 리스트입니다.
1. [tailwindcss](/tailwindcss) : rescript + react 프로젝트에 외부 의존성인 tailwindcss 를 설치하는 예제입니다.
1. [data_fetch](/data_fetch) : bs-fetch와 bs-json을 이용한 Remote API 요청 예제입니다.
1. [json_decode](/json_decode) : JSON 응답을 rescript 의 type을 가진 let-binding으로 변환하는 예제입니다.
1. [external_modules](/external_modules) : rescript의 외부 모듈 테스트 예제입니다.
1. [super_rentals](/super_rentals) : rescript + react 를 이용한 간단한 웹서비스입니다.


## 템플릿

1. [template_for_rescript](/template_for_rescript) : rescript만 이용하면 되는 프로젝트를 위한 템플릿입니다.
1. [template_for_react](/template_for_react) : rescript + react 를 이용하는 경우에 사용하는 템플릿입니다.

## 안내

공식 문서는 [이 곳](https://rescript-lang.org/) 입니다.

rescript의 한국어 문서는 [이 곳](https://green-labs.github.io/rescript-in-korean/)에 있습니다.

rescript+react 템플릿은 React Hooks 를 이용합니다. React Hook 은 [이 문서](https://reactjs.org/docs/hooks-intro.html) 를 참고하세요

rescript의 react활용은 [이 페이지](https://rescript-lang.org/docs/react/latest/introduction) 를 확인하세요.

## BuckleScript 와 ReasonML

아직 순수 rescript로 만들어진 프로젝트, 라이브러리 또는 예제가 많지 않습니다. 만약 rescript가 아닌 이전의 언어로 작성된 프로젝트를 rescript에서 사용해야한다면, rescript의 converter 기능을 이용해보세요.

```bash
npx rescript convert <파일경로>
```

자동으로 rescript 파일로 변환해줍니다.

## rescript-vscode

이 프로젝트의 개발은 vscode를 이용하고 있습니다. 개발을 시작하기 전에 [rescript-vscode](https://marketplace.visualstudio.com/items?itemName=chenglou92.rescript-vscode) 를 설치하고 사용해주세요.



## TODO

여유가 되면 추가해볼 내용입니다.

- [ ] rescript + react + electron
- [ ] rescript + next.js
- [ ] rescript + blitz.js
