class ExistingRegistrationPage < SitePrism::Page

  # What's your waste carrier registration number?

  element(:error_summary, ".error-summary")
  element(:heading, ".heading-large")

  element(:reg_no, "#renew_registration_form_temp_lookup_number")
  element(:submit_button, ".button")

  def submit(args = {})
    reg_no.set(args[:reg_no]) if args.key?(:reg_no)
    submit_button.click
  end

end
