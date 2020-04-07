class ContactPhonePage < SitePrism::Page

  # What's the contact telephone number?

  element(:heading, ".heading-large")
  element(:phone_number, "#contact_phone_form_phone_number")
  element(:submit_button, ".button")

  def submit(args = {})
    phone_number.set(args[:phone_number]) if args.key?(:phone_number)

    submit_button.click
  end
end
