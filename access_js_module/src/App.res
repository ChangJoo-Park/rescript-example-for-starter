@module("lodash") external minFromLodash: array<int> => int = "min"
@module("lodash") external maxFromLodash: array<int> => int = "max"

@react.component
let make = () => {
  let data = [-5, 0, 1, 2, 3, 4]

  let mininum = minFromLodash(data)

  let maximum = maxFromLodash(data)

  <div className="App">
    <h1> 최소 :  {React.string(Belt.Int.toString(mininum))} </h1>
    <h1> 최대 :  {React.string(Belt.Int.toString(maximum)))} </h1>
  </div>
}
