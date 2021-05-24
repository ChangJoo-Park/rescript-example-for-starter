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

  let rentalsData = data => {
    switch Js.Json.classify(data) {
    | Js.Json.JSONArray(data) => Js.Array.map(rental => {
        id: field("id", string, rental),
        title: field("title", string, rental),
        owner: field("owner", string, rental),
        city: field("city", string, rental),
        category: field("category", string, rental),
        bedrooms: field("bedrooms", int, rental),
        image: field("image", string, rental),
        description: field("description", string, rental),
      }, data)
    | _ => []
    }
  }
}

let useRentals = () => {
  let (rentals, setRentals) = React.useState((): array<rental> => [])

  let getRentals = () => {
    Fetch.fetch("/api/rentals.json")
    ->Js.Promise.then_(Fetch.Response.json, _)
    ->Js.Promise.then_(obj => obj->Decode.rentalsData->Js.Promise.resolve, _)
    ->Js.Promise.then_(rentals =>
      {
        setRentals(_ => rentals)
        rentals
      }->Js.Promise.resolve
    , _)
  }

  let filterRentals = term => {
    let toLowerCase = Js.String.toLowerCase
    let filter = Js.Array.filter
    let includes = Js.String.includes
    filter(rental => includes(toLowerCase(term), toLowerCase(rental.title)), rentals)
  }

  (rentals, getRentals, filterRentals)
}

@react.component
let make = () => {
  let (rentals, getRentals, filterRentals) = useRentals()
  let (filtered, setFiltered) = React.useState(() => rentals)

  let onSerchTermChange = evt => {
    let term = ReactEvent.Form.target(evt)["value"]
    switch term {
    | "" => setFiltered(_ => rentals)
    | _ => setFiltered(_ => filterRentals(term))
    }
  }

  React.useEffect0(() => {
    let _ =
      getRentals()->Js.Promise.then_(rentals => setFiltered(_ => rentals)->Js.Promise.resolve, _)
    None
  })

  let renderRentals = {
    Belt.Array.map(filtered, rental =>
      <RentalListItem
        key={rental.title}
        id={rental.id}
        title={rental.title}
        owner={rental.owner}
        city={rental.city}
        category={rental.category}
        bedrooms={rental.bedrooms}
        image={rental.image}
      />
    )->React.array
  }

  <>
    <div className="jumbo">
      <div className="right tomster" />
      <h2> {React.string("Welcome to Super Rentals!")} </h2>
      <p>
        {React.string("We hope you find exactly what you're looking for in a place to stay.")}
      </p>
      <Link href="/about" className="button"> {React.string("About Us")} </Link>
    </div>
    <div className="rentals">
      <label>
        <span> {React.string("Where would you like to stay?")} </span>
        <input className="ember-text-field light" type_="text" onChange=onSerchTermChange />
      </label>
      <ul className="results"> {renderRentals} </ul>
    </div>
  </>
}
