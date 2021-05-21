type location = {
  lat: float,
  lng: float
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

@react.component
let make = () => {
  let (searchTerm, setSerchTerm) = React.useState(() => "")
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
    }
  ])

  let (filtered, setFiltered) = React.useState(() => rentals)

  let onSerchTermChange = (evt) => {
    setSerchTerm(_ => ReactEvent.Form.target(evt)["value"])
    // let filteredRentals = filter((elm) => true, rentals)
    setFiltered(_ => [])
  }

  <>
    <div className="jumbo">
      <div className="right tomster"></div>
      <h2>{React.string("Welcome to Super Rentals!")}</h2>
      <p>{React.string("We hope you find exactly what you're looking for in a place to stay.")}</p>
      <Link href="/about" className="button">{React.string("About Us")}</Link>
    </div>
    <div className="rentals">
      <label>
        <span>{React.string("Where would you like to stay?")}</span>
        <input className="ember-text-field light" type_="text" onChange=onSerchTermChange></input>
      </label>

      <ul className="results">
      {Belt.Array.map(filtered, rental => <Rental
          key={rental.title}
          title={rental.title}
          owner={rental.owner}
          city={rental.city}
          category={rental.category}
          roomType={rental.roomType}
          bedrooms={rental.bedrooms}
          image={rental.image}
        ></Rental>)->React.array}
      </ul>
    </div>
  </>
}
