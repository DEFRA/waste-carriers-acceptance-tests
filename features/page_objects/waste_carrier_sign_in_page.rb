class WasteCarrierSignInPage < SitePrism::Page

  # Sign in

  set_url(Quke::Quke.config.custom["urls"]["front_office_sign_in"])

  # Cannot simply use the CSS # id selector because there are 2 elements on the
  # page with this id; one a div the other an input
  element(:email_address, "input[id='user_email']")
  element(:password, "input[id='user_password']")

  element(:submit_button, "#sign_in")

  def submit(args = {})
    email_address.set(args[:email]) if args.key?(:email)
    password.set(args[:password]) if args.key?(:password)

    submit_button.click
  end
end
