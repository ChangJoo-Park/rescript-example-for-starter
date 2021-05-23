
@react.component
let make = () => {
  let s = React.string
  let randomNumberForNotFound = string_of_int(Js.Math.random_int(0, 1000))
  <div>
    <h1> {s("This is Home Page")} </h1>

    <div>
      <Link href="/users">{s("Go user listing")}</Link>
    </div>
    <div>
      <Link href=`/somewhere/${randomNumberForNotFound}`>{s("Go to not found")}</Link>
    </div>
  </div>
}
