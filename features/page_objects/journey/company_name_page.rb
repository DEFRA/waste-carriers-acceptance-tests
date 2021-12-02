class CompanyNamePage < BasePage

  # whats the name of the company?
  element(:error_summary, ".govuk-error-summary__body")
  element(:company_name, "input[id^='company-name-form-company-name']")
  element(:heading, "h1")
  element(:submit_button, "[type='submit']")

  def submit(args = {})
    company_name.set(args[:company_name]) if args.key?(:company_name)

    submit_button.click
  end

end
