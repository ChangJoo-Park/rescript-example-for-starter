@react.component
let make = (~image: string) => {
  let (imageClass, setImageClass) = React.useState(() => "")

  let onClick = _ => {
    switch imageClass {
    | "" => setImageClass(_ => "large")

    | "large" => setImageClass(_ => "")

    | _ => setImageClass(_ => "")
    }
  }

  <button className={`image ${imageClass}`} type_="button" onClick>
    <img src=image /> <small> {React.string("View Larger")} </small>
  </button>
}
