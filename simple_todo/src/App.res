@module("./logo.svg") external logo: string = "default"

%%raw(`import './App.css';`)

type todo = {id: int, body: string, complete: bool}

@react.component
let make = () => {
  let (newTodoInput, setNewTodoInput) = React.useState(_ => "")

  let (todos, setTodos) = React.useState(_ => [
    {id: Js.Math.random_int(0, 999), body: "Todo 1", complete: false},
    {id: Js.Math.random_int(0, 999), body: "Todo 2", complete: false},
    {id: Js.Math.random_int(0, 999), body: "Todo 3", complete: false},
  ])

  let handleNewTodoInputChange = evt => setNewTodoInput(_ => ReactEvent.Form.target(evt)["value"])

  let onSubmit = evt => {
    ReactEvent.Form.preventDefault(evt)

    let newTodo = {
      id: Js.Math.random_int(0, 999),
      body: newTodoInput,
      complete: false,
    }

    let newTodoList = Js.Array2.concat(todos, [newTodo])
    setTodos(_ => newTodoList)
    setNewTodoInput(_ => "")
  }

  let onRemove = (_, id) => setTodos(_prev => todos->Js.Array2.filter(elm => elm.id !== id))

  <div>
    <div> <h1> {React.string("Simple Todo")} </h1> </div>
    <div>
      <form onSubmit={onSubmit}>
        <input value={newTodoInput} onChange={handleNewTodoInputChange} required=true />
      </form>
    </div>
    {Belt.Array.map(todos, todo => {
      <div key={Belt.Int.toString(todo.id)}>
        <button onClick={evt => onRemove(evt, todo.id)}> {React.string("X")} </button>
        {React.string(" - ")}
        {React.string(todo.body)}
      </div>
    })->React.array}
  </div>
}
