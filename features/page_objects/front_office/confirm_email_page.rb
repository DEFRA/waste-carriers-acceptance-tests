class ConfirmEmailPage < SitePrism::Page

  # Make sure this is right
  element(:email, "#send_email_here")

  element(:submit_button, "input[type='Submit']")

  def submit(args = {})
    email.set(args[:email]) if args.key?(:email)

    submit_button.click
  end

end
