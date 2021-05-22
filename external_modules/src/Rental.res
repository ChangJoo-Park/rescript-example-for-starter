type location = {
  lat: float,
  lng: float,
}

type category = Estate | Condo | Apartment

type rental = {
  id: string,
  title: string,
  category: category,
  owner: string,
  city: string,
  location: location,
  bedrooms: int,
  image: string,
  description: string,
}
