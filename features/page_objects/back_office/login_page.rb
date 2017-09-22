class LoginPage < SitePrism::Page

  set_url(Quke::Quke.config.custom["urls"]["back_office"])

  element(:email, "#cred_userid_inputtext")
  element(:password, "#cred_password_inputtext")

  element(:submit_button, "#cred_sign_in_button")

  def submit(args = {})
    email.set(args[:email]) if args.key?(:email)
    password.set(args[:password]) if args.key?(:password)
    submit_button.click
  end

end
