
@react.component
let make = () => {
  <div>
    <h1>{React.string("404 Not Found")}</h1>
    <div>
      <Link href="/">{React.string("Back to Home")}</Link>
    </div>
  </div>
}
