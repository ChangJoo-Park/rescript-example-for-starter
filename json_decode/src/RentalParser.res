type location = {
  lat: float,
  lng: float,
}

type rentals = {
  roomType: string,
  id: string,
  title: string,
  owner: string,
  city: string,
  location: location,
  category: string,
  rooms: int,
  image: string,
  description: string,
}

module RentalParser = {

  @scope("JSON") @val
  external parseRentals: string => rentals = "parse"

  let parse = (data: string) => parseRentals(data)
}
