@react.component
let make = () => {
  <div className="jumbo">
    <div className="right tomster" />
    <h2> {React.string("Contact Us")} </h2>
    <p>
      {React.string("Super Rentals Representatives would love to help you")}
      {React.string("choose a destination or answer any questions you may have.")}
    </p>
    <address>
      {React.string("Super Rentals HQ")}
      <p>
        {React.string("1212 Test Address Avenue")} <br /> {React.string("Testington, OR 97233")}
      </p>
      <a href="tel:503.555.1212"> {React.string("+1 (503) 555-1212")} </a>
      <br />
      <a href="mailto:superrentalsrep@emberjs.com">
        {React.string("superrentalsrep@emberjs.com")}
      </a>
    </address>

    <Link href="/about" className="button">{React.string("About")}</Link>
  </div>
}
