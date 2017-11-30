class CorrespondenceContactEmailPage < SitePrism::Page

  # What’s the email address of the person we should contact?
  element(:contact_email, "#correspondence_contact_email[email_address]")
  element(:confirm_email, "#correspondence_contact_email_email_address_confirmation")

  element(:submit_button, "input[value='Continue']")

  def submit(args = {})
    contact_email.set(args[:contact_email]) if args.key?(:contact_email)
    confirm_email.set(args[:confirm_email]) if args.key?(:confirm_email)

    submit_button.click
  end

end