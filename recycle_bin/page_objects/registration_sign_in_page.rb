class RegistrationSignInPage < SitePrism::Page

  # Sign in during a registration journey with existing customer email

  element(:email, "input[id='registration_accountEmail']")
  element(:password, "input[id='registration_password']")

  element(:submit_button, "input[type='submit']")

  def submit(args = {})
    email.set(args[:email]) if args.key?(:email)

    password.set(args[:password]) if args.key?(:password)

    submit_button.click
  end
end
