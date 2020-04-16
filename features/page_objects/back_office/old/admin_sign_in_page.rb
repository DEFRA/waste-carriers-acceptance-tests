class AdminSignInPage < SitePrism::Page

  set_url(Quke::Quke.config.custom["urls"]["old_back_end_admin"])

  element(:email, "#admin_email")
  element(:password, "#admin_password")

  element(:submit_button, "#sign_in")

  def submit(args = {})
    email.set(args[:email]) if args.key?(:email)
    password.set(args[:password]) if args.key?(:password)
    submit_button.click
  end

end
