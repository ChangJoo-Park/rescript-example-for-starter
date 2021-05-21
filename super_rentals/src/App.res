@react.component
let make = () => {
  let url = RescriptReactRouter.useUrl()

  <div className="container">
    <Header></Header>
    <div className="body">
    {
      switch url.path {
      | list{ "about" } => <AboutPage />
      | list{ "contact" } => <ContactPage />
      | list{ } => <HomePage />
      | _ => <NotFound />
      }
    }
    </div>
  </div>
}
