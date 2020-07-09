class ContactEmailPage < SitePrism::Page

  # What's the contact email address?

  element(:error_summary, ".error-summary")
  element(:heading, ".heading-large")

  element(:email, "#contact_email_form_contact_email")
  element(:confirm_email, "#contact_email_form_confirmed_email")
  element(:submit_button, ".button")

  def submit(args = {})
    email.set(args[:email]) if args.key?(:email)
    confirm_email.set(args[:confirm_email]) if args.key?(:confirm_email)

    submit_button.click
  end

end
