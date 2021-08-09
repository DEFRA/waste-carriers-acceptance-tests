class CompanyNumberPage < SitePrism::Page

  # Business details

  element(:error_summary, ".govuk-error-summary__body")
  element(:heading, "h1")

  element(:companies_house_number, "input[id^='registration-number-form-company-no']")
  element(:submit_button, "[type='submit']")

  def submit(args = {})
    companies_house_number.set(args[:companies_house_number]) if args.key?(:companies_house_number)

    submit_button.click
  end

end
