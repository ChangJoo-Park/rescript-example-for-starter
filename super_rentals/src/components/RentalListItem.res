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

@react.component
let make = (
  ~id: string,
  ~title: string,
  ~owner: string,
  ~city: string,
  ~category: string,
  ~bedrooms: int,
  ~image: string,
) => {

  <article className="rental">
    <RentalImage image=image></RentalImage>
    <div className="details">
      <h3> <Link href={`/rentals/${id}`}> {React.string(title)} </Link> </h3>
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
