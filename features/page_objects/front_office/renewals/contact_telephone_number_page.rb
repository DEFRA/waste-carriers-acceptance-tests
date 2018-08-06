class ContactTelephoneNumberPage < SitePrism::Page

  element(:phone_number, "#registration_phoneNumber")
  element(:heading, :xpath, "//h1[contains(text(), 'telephone number')]")
  element(:submit_button, "input[type='submit']")

  def submit(args = {})
    wait_for_heading
    phone_number.set(args[:phone_number]) if args.key?(:phone_number)

    submit_button.click
  end

end
