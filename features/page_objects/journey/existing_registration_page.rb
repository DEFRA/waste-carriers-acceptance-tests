class ExistingRegistrationPage < BasePage

  # What's your waste carrier registration number?

  element(:error_summary, ".govuk-error-summary__body")
  element(:heading, "h1")

  element(:reg_no, "#renew-registration-form-temp-lookup-number-field")
  element(:submit_button, "[type='submit']")

  def submit(args = {})
    reg_no.set(args[:reg_no]) if args.key?(:reg_no)
    submit_button.click
  end

end
