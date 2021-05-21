@module("./logo.svg") external logo: string = "default"

%%raw(`import './App.css';`)

@react.component
let make = () => {
  let (count, setCount) = React.useState(() => 0)
  let onIncrease = _ => setCount(current => current + 1)
  let onDecrease = _ => setCount(current => current - 1)

  <div className="App">
    <div> {React.string("Counter App")} </div>
    <div> {React.string(Js.Int.toString(count))} </div>
    <div>
      <button onClick=onDecrease> {React.string("-1")} </button>
      <button onClick=onIncrease> {React.string("+1")} </button>
    </div>
  </div>
}
