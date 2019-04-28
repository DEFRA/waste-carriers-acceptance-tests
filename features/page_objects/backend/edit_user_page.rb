# frozen_string_literal: true

class EditUserPage < SitePrism::Page

  element(:email, "#agency_user_email")
  element(:password, "#agency_user_password")

  element(:submit_button, "#create_agency_user")

  def submit(args = {})
    email.set(args[:email]) if args.key?(:email)
    password.set(args[:password]) if args.key?(:password)

    submit_button.click
  end

end
