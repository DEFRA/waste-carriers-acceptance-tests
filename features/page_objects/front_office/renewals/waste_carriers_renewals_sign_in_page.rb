class WasteCarrierRenewalsSignInPage < SitePrism::Page

  # Sign in for external users on new app.
  # This page will become redundant when we remove accounts.

  set_url(Quke::Quke.config.custom["urls"]["front_office_sign_in"])

  # Cannot simply use the CSS # id selector because there are 2 elements on the
  # page with this id; one a div the other an input
  element(:email_address, "input[id='user_email']")
  element(:password, "input[id='user_password']")

  element(:submit_button, "input[value='Sign in']")

  def submit(args = {})
    email_address.set(args[:email]) if args.key?(:email)

    password.set(args[:password]) if args.key?(:password)

    submit_button.click
  end
end
