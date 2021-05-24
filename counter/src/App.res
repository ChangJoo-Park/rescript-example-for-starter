%%raw(`import './App.css';`)

type counterAction = Increase | Decrease

@react.component
let make = () => {
  let (count, setCount) = React.useState(() => 0)

  let dispatch = action =>
    switch action {
    | Increase => setCount(current => current + 1)
    | Decrease => setCount(current => current - 1)
    }

  <div className="App">
    <div> {React.string("Counter App")} </div>
    <div> {React.string(Belt.Int.toString(count))} </div>
    <div>
      <button onClick={_ => dispatch(Decrease)}> {React.string("-1")} </button>
      <button onClick={_ => dispatch(Increase)}> {React.string("+1")} </button>
    </div>
  </div>
}
