type location = {
  lat: float,
  lng: float,
}

type rental = {
  title: string,
  owner: string,
  city: string,
  location: location,
  category: string,
  roomType: string,
  bedrooms: int,
  image: string,
  description: string,
}

let useRentals = () => {
  let (rentals, setRentals) = React.useState(() => [
    {
      title: "Grand Old Mansion",
      owner: "Veruca Salt",
      city: "San Francisco",
      location: {
        lat: 37.7749,
        lng: -122.4194,
      },
      category: "Estate",
      roomType: "Standalone",
      bedrooms: 15,
      image: "https://upload.wikimedia.org/wikipedia/commons/c/cb/Crane_estate_(5).jpg",
      description: "This grand old mansion sits on over 100 acres of rolling hills and dense redwood forests.",
    },
  ])

  let getRentals = () => {
    setRentals(_ => [])
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
  let (rentals, _, filterRentals) = useRentals()
  let (filtered, setFiltered) = React.useState(() => rentals)

  let onSerchTermChange = evt => {
    let term = ReactEvent.Form.target(evt)["value"]
    switch term {
    | "" => setFiltered(_ => rentals)
    | _ => setFiltered(_ => filterRentals(term))
    }
  }

  let renderRentals = {
    Belt.Array.map(filtered, rental =>
      <Rental
        key={rental.title}
        title={rental.title}
        owner={rental.owner}
        city={rental.city}
        roomType={rental.roomType}
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
