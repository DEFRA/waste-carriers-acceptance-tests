class ResetPasswordPage < SitePrism::Page

  # Reset your password / set your password / change password (shared page object)
  # This page will become redundant when we remove accounts.

  element(:heading, "h1")
  element(:email_address, "input[id='user_email']")
  element(:current_password_field, "#user-current-password-field")
  element(:password_field, "#user-password-field")
  element(:confirm_password_field, "#user-password-confirmation-field")
  element(:reset_password_field, "input[name='user[password]']")
  element(:confirm_reset_password_field, "input[name='user[password_confirmation]']")
  element(:submit_button, "[type='submit']")

  def change_password(args = {})
    email_address.set(args[:email]) if args.key?(:email)
    current_password_field.set(args[:current_password]) if args.key?(:current_password)
    password_field.set(args[:password]) if args.key?(:password)
    confirm_password_field.set(args[:password]) if args.key?(:password)
    submit_button.click
  end

  def reset_password(args = {})
    reset_password_field.set(args[:password]) if args.key?(:password)
    confirm_reset_password_field.set(args[:password]) if args.key?(:password)
    submit_button.click
  end

end
