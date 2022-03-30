class ContactPhonePage < BasePage

  # What's the contact telephone number?

  element(:phone_number, "input[id^='contact-phone-form-phone-number-field']")

  def submit(args = {})
    phone_number.set(args[:phone_number]) if args.key?(:phone_number)

    submit_button.click
  end
end
