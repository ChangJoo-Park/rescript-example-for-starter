@react.component
let make = (~userId: string) => {
  let s = React.string
  <div>
    <h1> {s("This is User Details")} </h1>
    <p> {s(`Hello, ${userId}!`)} </p>
    <div> <Link href="/"> {s("Back to user Listing")} </Link> </div>
    <div> <Link href="/"> {s("Go to home")} </Link> </div>
  </div>
}
