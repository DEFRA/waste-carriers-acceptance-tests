class CompanyNamePage < BasePage

  # whats the name of the company?

  element(:company_name, "input[id^='company-name-form-company-name']")

  def submit(args = {})
    company_name.set(args[:company_name]) if args.key?(:company_name)

    submit_button.click
  end

end
