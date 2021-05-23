type todo = {
  userId: int,
  id: int,
  title: string,
  completed: bool,
}

@scope("JSON") @val
external parseTodo: Js.Json.t => todo = "parse"

let main = () => {
  let item: Js.Promise.t<todo> =
    Fetch.fetch("https://jsonplaceholder.typicode.com/todos/1")
    ->Js.Promise.then_(res => Fetch.Response.json(res), _)
    ->Js.Promise.then_(res => parseTodo(res)->Js.Promise.resolve, _)
  Js.log(item)
}
