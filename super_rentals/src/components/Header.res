@react.component
let make = () => {
  <nav className="menu">
    <Link href="/" className="active menu-index"> <h1> {React.string("SuperRentals")} </h1> </Link>
    <div className="links">
      <Link href="/about" className="menu-about"> {React.string("About")} </Link>
      <Link href="/getting-in-touch" className="menu-contact"> {React.string("Contact")} </Link>
    </div>
  </nav>
}
