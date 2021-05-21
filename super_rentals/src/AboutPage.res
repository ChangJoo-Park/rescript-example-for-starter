@react.component
let make = () => {
  <>
  <div className="jumbo">
    <div className="right tomster"></div>
    <h2>{React.string("About Super Rentals")}</h2>
    <p>
      {React.string("The Super Rentals website is a delightful project created to explore Ember.")}
      {React.string("By building a property rental site,")}
      {React.string("we can simultaneously imagine traveling AND building Ember applications.")}
      <br/>
    </p>
  </div>
  </>
}
