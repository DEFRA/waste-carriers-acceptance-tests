class ContactPhonePage < SitePrism::Page

  # What's the contact telephone number?

  element(:error_summary, ".govuk-error-summary__body")
  element(:heading, "h1")

  element(:phone_number, "input[id^='contact-phone-form-phone-number-field']")
  element(:submit_button, "[type='submit']")

  def submit(args = {})
    phone_number.set(args[:phone_number]) if args.key?(:phone_number)

    submit_button.click
  end
end
