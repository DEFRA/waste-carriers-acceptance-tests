class SignupPage < SitePrism::Page

  # Check your details before registering
  element(:confirm_email, "input[name='registration[accountEmail_confirmation]'")
  element(:registration_password, "input[name='registration[password]'")
  element(:confirm_password, "input[name='registration[password_confirmation]'")

  element(:submit_button, "input[type='Submit']")

  def submit(args = {})
    confirm_email.set(args[:confirm_email]) if args.key?(:confirm_email)
    registration_password.set(args[:registration_password]) if args.key?(:registration_password)
    confirm_password.set(args[:confirm_password]) if args.key?(:confirm_password)
    submit_button.click
  end

end
