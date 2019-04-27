# frozen_string_literal: true

class NewUsersPage < SitePrism::Page

  set_url(join_url(Quke::Quke.config.custom["urls"]["backend"], "/agency_users/new"))

  element(:email, "#agency_user_email")
  element(:password, "#agency_user_password")

  element(:submit_button, "input[name='continue']")

  def submit(args = {})
    email.set(args[:email]) if args.key?(:email)
    password.set(args[:password]) if args.key?(:password)

    submit_button.click
  end

end
