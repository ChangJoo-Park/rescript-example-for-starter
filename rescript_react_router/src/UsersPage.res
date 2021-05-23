type user = {
  id: string,
  name: string,
}
@react.component
let make = () => {
  let s = React.string

  let users: array<user> = [
    {id: "tony-stark", name: "Tony Stark"},
    {id: "steven-rogers", name: "Steven Rogers"},
    {id: "natasha-romanoff", name: "Natasha Romanoff"},
  ]

  let renderUsers =
    Js.Array.map(
      (user: user) =>
        <li key=user.id> <Link href={`/users/${user.id}`}> {s(user.name)} </Link> </li>,
      users,
    )->React.array

  <div>
    <h1> {s("This is User Listing")} </h1>
    <ul> {renderUsers} </ul>
    <div> <Link href="/"> {s("Go to home")} </Link> </div>
  </div>
}
