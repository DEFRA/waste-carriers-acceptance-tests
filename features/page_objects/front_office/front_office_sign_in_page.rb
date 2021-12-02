class FrontOfficeSignInPage < BasePage

  # Sign in for external users on new app.
  # This page will become redundant when we remove accounts.

  set_url(Quke::Quke.config.custom["urls"]["front_office_sign_in"])

  element(:error_summary, ".govuk-error-summary")
  element(:email_address, "#user-email-field")
  element(:password, "#user-password-field")

  element(:submit_button, "input[value='Sign in']")

  element(:forgotten_link, "span", text: "I've forgotten my password")
  element(:reset_password_link, "a[href*='/users/password/new'")

  def submit(args = {})
    email_address.set(args[:email]) if args.key?(:email)
    password.set(args[:password]) if args.key?(:password)

    submit_button.click
  end
end
