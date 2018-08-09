class AdminSignInPage < SitePrism::Page

  set_url(Quke::Quke.config.custom["urls"]["back_office_renewals_sign_in"])

  element(:email, "#user_email")
  element(:password, "#user_password")

  element(:submit_button, "input[name='commit']")

  def submit(args = {})
    email.set(args[:email]) if args.key?(:email)
    password.set(args[:password]) if args.key?(:password)
    submit_button.click
  end

end
