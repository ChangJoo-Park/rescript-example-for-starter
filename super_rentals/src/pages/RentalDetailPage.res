type rental = {
  id: string,
  title: string,
  owner: string,
  city: string,
  category: string,
  bedrooms: int,
  image: string,
  description: string,
}

module Decode = {
  open Json.Decode
  let rentalData = (rental: Js.Json.t): rental => {
    id: field("id", string, rental),
    title: field("title", string, rental),
    owner: field("owner", string, rental),
    city: field("city", string, rental),
    category: field("category", string, rental),
    bedrooms: field("bedrooms", int, rental),
    image: field("image", string, rental),
    description: field("description", string, rental),
  }
}

@react.component
let make = (~id: string) => {
  let getRental = (id: string): Js.Promise.t<rental> =>
    Fetch.fetch(`/api/rentals/${id}.json`)
    ->Js.Promise.then_(Fetch.Response.json, _)
    ->Js.Promise.then_(obj => obj->Decode.rentalData->Js.Promise.resolve, _)

  let (rental, setRental) = React.useState(_ => None)

  React.useEffect0(() => {
    let _ =
      getRental(id)->Js.Promise.then_(data => setRental(_ => Some(data))->Js.Promise.resolve, _)
    None
  })

  <>
    {switch rental {
    | Some(rental) => {
      <>
        <div className="jumbo">
          <div className="right tomster"></div>
          <h2> {React.string(rental.title)} </h2>
          <p>
            {React.string(`Nice find! This looks like a nice place to stay near ${rental.city}.`)}
            <br />
          </p>
          <a
            href=`https://twitter.com/intent/tweet?text=Rescript+is+Awesome`
            target="_blank"
            rel="external nofollow noopener noreferrer"
            className="share button">
            {React.string("Share on Twitter")}
          </a>
        </div>
        <div className="rental detailed">
          <RentalImage image=rental.image />
          <div className="details">
            <h3> {React.string(`About ${rental.title}`)} </h3>
            <div className="detail owner">
              <span> {React.string("Owner:")} </span> {React.string(rental.owner)}
            </div>
            <div className="detail type">
              <span> {React.string("Type:")} </span> {React.string(rental.category)}
            </div>
            <div className="detail location">
              <span> {React.string("Location:")} </span> {React.string(rental.city)}
            </div>
            <div className="detail bedrooms">
              <span> {React.string("Number of bedrooms:")} </span>
              {React.string(Belt.Int.toString(rental.bedrooms))}
            </div>
            <div className="detail description"> <p> {React.string(rental.description)} </p> </div>
          </div>
        </div>
      </>
      }
    | None => <div> {React.string(`데이터가 없음`)} </div>
    }}
  </>
}
