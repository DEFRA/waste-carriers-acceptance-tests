class SignInPage < BasePage
  set_url(Quke::Quke.config.custom["urls"]["back_office_sign_in"])

  element(:email, "[id^='user-email-field']")
  element(:password, "[id^='user-password-field']")

  def submit(args = {})
    email.set(args[:email]) if args.key?(:email)
    password.set(args[:password]) if args.key?(:password)
    submit_button.click
  end
end
