@module("./logo.svg") external logo: string = "default"

%%raw(`import './App.css';`)

@react.component
let make = () => {
  <div className="App">
    <div>{React.string(`헬로 월드!`)}</div>
    <div>{React.string(`おはようございます`)}</div>
    <div>{React.string(`你好`)}</div>
    <div>{React.string("헬로 월드!")}</div>
    <div>{React.string("おはようございます")}</div>
    <div>{React.string("你好")}</div>
  </div>
}
