class ContactTelephoneNumberPage < SitePrism::Page

  element(:phone_number, "#contact_phone_form_phone_number")
  element(:heading, :xpath, "//h1[contains(text(), 'telephone number')]")
  element(:submit_button, ".button")

  def submit(args = {})
    phone_number.set(args[:phone_number]) if args.key?(:phone_number)

    submit_button.click
  end

end
