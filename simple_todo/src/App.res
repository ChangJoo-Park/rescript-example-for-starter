@module("./logo.svg") external logo: string = "default"

%%raw(`import './App.css';`)

type todo = {id: int, body: string, complete: bool}

@react.component
let make = () => {
  let (newTodoInput, setNewTodoInput) = React.useState(_ => "")
  let (todos, setTodos) = React.useState(_ => [
    {id: Js.Math.random_int(0, 999), body: "Todo 1", complete: false},
    {id: Js.Math.random_int(0, 999), body: "Todo 2", complete: true},
    {id: Js.Math.random_int(0, 999), body: "Todo 3", complete: false},
  ])
  let handleNewTodoInputChange = evt => setNewTodoInput(_ => ReactEvent.Form.target(evt)["value"])
  let onSubmit = evt => {
    ReactEvent.Form.preventDefault(evt)
    let newTodo = {id: Js.Math.random_int(0, 999), body: newTodoInput, complete: false}
    setTodos(_ => Js.Array2.concat(todos, [newTodo]))
    setNewTodoInput(_ => "")
  }
  // If statement를 switch로 바꿀 수 있는 방법은 있는지?
  let toggledTodosById = (id, todos) => Js.Array.map(todo => {
      if todo.id === id {
        {...todo, complete: !todo.complete}
      } else {
        todo
      }
    }, todos)
  let onToggleComplete = (evt, id: int, todos) => {
    ReactEvent.Form.preventDefault(evt)
    setTodos(_ => toggledTodosById(id, todos))
  }
  let onRemove = (_, id) => setTodos(_prev => todos->Js.Array2.filter(elm => elm.id !== id))

  <div>
    <div> <h1> {React.string("Simple Todo")} </h1> </div>
    <div>
      <form onSubmit>
        <input value={newTodoInput} onChange={handleNewTodoInputChange} required=true />
      </form>
    </div>
    // {Belt.Array.map(todos, todo => {
    //   <div key={Belt.Int.toString(todo.id)}>
    //     <input
    //       type_="checkbox"
    //       checked=todo.complete
    //       onChange={evt => onToggleComplete(evt, todo.id, todos)}
    //     />
    //     {React.string(todo.complete ? "true" : "false")}
    //     {React.string(" - ")}
    //     {React.string(todo.body)}
    //     <button onClick={evt => onRemove(evt, todo.id)}> {React.string("X")} </button>
    //   </div>
    // })->React.array}
    {Belt.Array.map(todos, todo => {
      <div key={Belt.Int.toString(todo.id)}>
        <input
          type_="checkbox"
          checked=todo.complete
          onChange={evt => onToggleComplete(evt, todo.id, todos)}
        />
        {React.string(todo.complete ? "true" : "false")}
        {React.string(" - ")}
        {React.string(todo.body)}
        <button onClick={evt => onRemove(evt, todo.id)}> {React.string("X")} </button>
      </div>
    })->React.array}
  </div>
}
