class AgencyUsersPage < SitePrism::Page

  # Listing agency users

  element(:add_user, "#new_agency_user")
  element(:email, "#agency_user_email")
  element(:password, "#agency_user_password")
  element(:sign_out, "#signout_button")

  element(:submit_button, "input[name='continue']")

  def submit(args = {})
    email.set(args[:email]) if args.key?(:email)
    password.set(args[:password]) if args.key?(:password)
    submit_button.click
  end

end
