class AgencySignInPage < SitePrism::Page

  set_url(Quke::Quke.config.custom["urls"]["old_back_end"])

  element(:email, "#agency_user_email")
  element(:password, "#agency_user_password")

  element(:submit_button, "#sign_in")

  def submit(args = {})
    email.set(args[:email]) if args.key?(:email)
    password.set(args[:password]) if args.key?(:password)
    submit_button.click
  end

end
