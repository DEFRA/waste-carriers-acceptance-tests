# frozen_string_literal: true

class SignupPage < SitePrism::Page

  # We have to use xpath here because someone when creating the view used the
  # same ID for the field and the div which surrounds it, for each field on the
  # page!!
  element(:confirm_email, :xpath, "//input[@id='registration_accountEmail_confirmation']")
  element(:password, :xpath, "//input[contains(@name,'registration[password]')]")
  element(:confirm_password, :xpath, "//input[@id='registration_password_confirmation']")

  element(:submit_button, "#continue")

  def submit(args = {})
    confirm_email.set(args[:confirm_email]) if args.key?(:confirm_email)
    password.set(args[:password]) if args.key?(:password)
    confirm_password.set(args[:confirm_password]) if args.key?(:confirm_password)

    submit_button.click
  end

end
