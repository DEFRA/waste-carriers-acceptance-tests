class SignInPage < SitePrism::Page

  # Cannot simply use the CSS # id selector because there are 2 elements on the
  # page with this id; one a div the other an input
  element(:email_address, "input[id='registration_accountEmail']")
  element(:password, "input[id='registration_password']")

  element(:submit_button, "#continue")

  def submit(args = {})
    email_address.set(args[:email]) if args.key?(:email)
    password.set(args[:password]) if args.key?(:password)

    submit_button.click
  end
end
