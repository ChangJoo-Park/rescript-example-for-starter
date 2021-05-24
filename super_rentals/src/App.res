@react.component
let make = () => {
  let url = RescriptReactRouter.useUrl()

  <div className="container">
    <Header />
    <div className="body">
      {switch url.path {
      | list{"about"} => <AboutPage />
      | list{"getting-in-touch"} => <ContactPage />
      | list{"rentals", id} =>  <RentalDetailPage id=id />
      | list{} => <HomePage />

      | _ => <NotFound />
      }}
    </div>
  </div>
}
