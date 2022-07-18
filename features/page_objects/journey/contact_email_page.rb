class ContactEmailPage < BasePage

  # What's the contact email address?

  element(:email, "input[id^='contact-email-form-contact-email-field']")
  element(:confirm_email, "input[id^='contact-email-form-confirmed-email-field']")
  element(:no_email, "#contact-email-form-no-contact-email-1-field")

  def submit(args = {})
    email.set(args[:email]) if args.key?(:email)
    confirm_email.set(args[:confirm_email]) if args.key?(:confirm_email)
    no_email.click if args.key?(:no_email)
    submit_button.click
  end

end
