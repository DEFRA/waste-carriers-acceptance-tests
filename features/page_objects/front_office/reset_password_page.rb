class ResetPasswordPage < SitePrism::Page

  # Reset your password / set your password / change password (shared page object)
  # This page will become redundant when we remove accounts.

  element(:heading, "h1")
  element(:email_address, "input[id='user_email']")
  element(:current_password_field, "#user_current_password")
  element(:password_field, "#user_password")
  element(:confirm_password_field, "#user_password_confirmation")
  element(:submit_button, "[type='submit']")

  def submit(args = {})
    email_address.set(args[:email]) if args.key?(:email)
    current_password_field.set(args[:current_password]) if args.key?(:current_password)
    password_field.set(args[:password]) if args.key?(:password)
    confirm_password_field.set(args[:password]) if args.key?(:password)
    submit_button.click
  end

end
