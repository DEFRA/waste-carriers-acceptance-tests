class CertificateConfirmEmailPage < BasePage

  element(:email, "#email")

  def submit(args = {})
    email.set(args[:email]) if args.key?(:email)
    submit_button.click
  end

end
