@module("lodash")
external minFromLodash: array<int> => int = "min"

@module("lodash")
external maxFromLodash: array<int> => int = "max"

@module("./modules/sum.js")
external sumFromModule: (int, int) => int = "sum"

@react.component
let make = () => {
  let data = [-1, 0, 1, 2, 3, 4]
  let mininum = minFromLodash(data)

  let maximum = maxFromLodash(data)

  let sum = sumFromModule(1, 2)
  let dataToString =
    data->Belt.Array.map(x => Belt.Int.toString(x))->Belt.Array.reduce("", (a, b) => a ++ " " ++ b)
  let minimumToString = Belt.Int.toString(mininum)
  let maximumToString = Belt.Int.toString(maximum)
  let sumToString = Belt.Int.toString(sum)

  <div className="App">
    <h1> {React.string(dataToString)} </h1>
    <h2> {React.string(`최소 : ${minimumToString}`)} </h2>
    <h2> {React.string(`최대 : ${maximumToString}`)} </h2>
    <h2> {React.string(`두 수(1, 2)의 합 : ${sumToString}`)} </h2>
  </div>
}
