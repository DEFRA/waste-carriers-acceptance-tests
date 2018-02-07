class ContactTelephoneNumberPage < SitePrism::Page

  element(:phone_number, "#registration_phoneNumber")
  element(:submit_button, "input[type='submit']")

  def submit(args = {})
    phone_number.set(args[:phone_number]) if args.key?(:phone_number)

    submit_button.click
  end

end
