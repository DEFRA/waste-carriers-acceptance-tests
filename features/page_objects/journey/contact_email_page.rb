class ContactEmailPage < BasePage

  # What's the contact email address?

  element(:error_summary, ".govuk-error-summary__body")
  element(:heading, "h1")

  element(:email, "input[id^='contact-email-form-contact-email-field']")
  element(:confirm_email, "input[id^='contact-email-form-confirmed-email-field']")
  element(:submit_button, "[type='submit']")

  def submit(args = {})
    email.set(args[:email]) if args.key?(:email)
    confirm_email.set(args[:confirm_email]) if args.key?(:confirm_email)

    submit_button.click
  end

end
