class ContactDetailsPage < SitePrism::Page

  # Contact details
  element(:first_name, "#registration_firstName")
  element(:last_name, "#registration_lastName")
  element(:phone_number, "#registration_phoneNumber")
  element(:email, "#registration_contactEmail")

  element(:submit_button, "input[type='Submit']")

  def submit(args = {})
    first_name.set(args[:first_name]) if args.key?(:first_name)
    last_name.set(args[:last_name]) if args.key?(:last_name)
    phone_number.set(args[:phone_number]) if args.key?(:phone_number)
    email.set(args[:email]) if args.key?(:email)

    submit_button.click
  end

end
