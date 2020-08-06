require_relative "sections/govuk_banner.rb"

class TransferRegistrationPage < SitePrism::Page

  section(:govuk_banner, GovukBanner, GovukBanner::SELECTOR)

  element(:email, "#registration_transfer_form_email")
  element(:confirm_email, "#registration_transfer_form_confirm_email")

  element(:submit_button, "input[name='commit']")

  def submit(args = {})
    email.set(args[:email]) if args.key?(:email)
    confirm_email.set(args[:confirm_email]) if args.key?(:confirm_email)

    submit_button.click
  end

end
