class SignupPage < SitePrism::Page

  # Check your details before registering
  element(:confirm_email, :xpath, "//input[@id='registration_accountEmail_confirmation']")
  element(:registration_password, :xpath, "//input[contains(@name,'registration[password]')]")
  element(:confirm_password, :xpath, "//input[@id='registration_password_confirmation']")

  element(:submit_button, "input[type='Submit']")

  def submit(args = {})
    confirm_email.set(args[:confirm_email]) if args.key?(:confirm_email)
    registration_password.set(args[:registration_password]) if args.key?(:registration_password)
    confirm_password.set(args[:confirm_password]) if args.key?(:confirm_password)
    submit_button.click
  end

end
