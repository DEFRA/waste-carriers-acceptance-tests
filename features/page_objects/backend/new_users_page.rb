# frozen_string_literal: true

class NewUsersPage < SitePrism::Page

  set_url(join_url(Quke::Quke.config.custom["urls"]["backend"], "/agency_users/new"))

  element(:email, "#agency_user_email")
  element(:password, "#agency_user_password")
  element(:roles, "#agency_user_roles")

  element(:submit_button, "#create_agency_user")

  def submit(args = {})
    email.set(args[:email]) if args.key?(:email)
    password.set(args[:password]) if args.key?(:password)
    select_role(args[:role]) if args.key?(:role)

    submit_button.click
  end

  private

  def select_role(role)
    case role
    when :finance_basic
      roles.select("Finance User")
    when :finance_admin
      roles.select("Finance Admin User")
    when :agency_refund_payment
      roles.select("EA User with Refunds and Payments")
    end
  end

end
