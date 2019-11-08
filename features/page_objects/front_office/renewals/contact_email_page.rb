class ContactEmailPage < SitePrism::Page

  element(:email, "#contact_email_form_contact_email")
  element(:confirm_email, "#contact_email_form_confirmed_email")

  element(:heading, :xpath, "//h1[contains(text(), 'email address')]")
  element(:submit_button, ".button")

  def submit(args = {})
    email.set(args[:email]) if args.key?(:email)
    confirm_email.set(args[:confirm_email]) if args.key?(:confirm_email)

    submit_button.click
  end

end
