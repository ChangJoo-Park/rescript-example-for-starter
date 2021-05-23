@react.component
let make = () => {
  let url = RescriptReactRouter.useUrl()

  <div className="container">
    <div className="body">
      {switch url.path {
      | list{"about"} => <AboutPage />
      | list{"users"} => <UsersPage />
      | list{"users", userId} => <UserDetailPage userId=userId />
      | list{} => <HomePage />
      | _ => <NotFoundPage />
      }}
    </div>
  </div>
}
