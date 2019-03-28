# frozen_string_literal: true

class ContactDetailsPage < SitePrism::Page

  element(:first_name, "#registration_firstName")
  element(:last_name, "#registration_lastName")
  element(:phone_number, "#registration_phoneNumber")
  element(:email, "#registration_contactEmail")

  element(:submit_button, "#continue")

  def submit(args = {}, url_is_internal = false)
    first_name.set(args[:first_name]) if args.key?(:first_name)
    last_name.set(args[:last_name]) if args.key?(:last_name)
    phone_number.set(args[:telephone]) if args.key?(:telephone)
    unless url_is_internal
      email.set(args[:email]) if args.key?(:email)
    end

    submit_button.click
  end

end
