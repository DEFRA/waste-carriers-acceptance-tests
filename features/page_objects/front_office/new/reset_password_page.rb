class ResetPasswordPage < SitePrism::Page

  # Reset your password / change your password
  # This page will become redundant when we remove accounts.

  element(:heading, ".heading-large")
  element(:email_address, "input[id='user_email']")
  element(:password_field, "#user_password")
  element(:confirm_password_field, "#user_password_confirmation")
  element(:submit_button, ".button")

  def submit(args = {})
    email_address.set(args[:email]) if args.key?(:email)
    password_field.set(args[:password]) if args.key?(:password)
    confirm_password_field.set(args[:password]) if args.key?(:password)
    submit_button.click
  end

end
