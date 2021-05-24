type location = {
  lat: float,
  lng: float,
}

@react.component
let make = (
  ~title: string,
  ~owner: string,
  ~city: string,
  ~category: string,
  ~bedrooms: int,
  ~image: string,
) => {
  let (imageClass, setImageClass) = React.useState(() => "")

  let onClick = _ => {
    switch imageClass {
    | "" => setImageClass(_ => "large")

    | "large" => setImageClass(_ => "")

    | _ => setImageClass(_ => "")
    }
  }

  <article className="rental">
    <button className={`image ${imageClass}`} type_="button" onClick>
      <img src=image /> <small> {React.string("View Larger")} </small>
    </button>
    <div className="details">
      <h3> {React.string(title)} </h3>
      <div />
      <div className="detail owner">
        <span> {React.string("Owner: ")} </span> {React.string(owner)}
      </div>
      <div className="detail type">
        <span> {React.string("Type: ")} </span> {React.string(category)}
      </div>
      <div className="detail location">
        <span> {React.string("Location: ")} </span> {React.string(city)}
      </div>
      <div className="detail bedrooms">
        <span> {React.string("Number of bedrooms: ")} </span>
        {React.string(Belt.Int.toString(bedrooms))}
      </div>
    </div>
  </article>
}
