class CompanyNumberPage < BasePage

  # Business details

  element(:companies_house_number, "input[id^='registration-number-form-company-no']")

  def submit(args = {})
    companies_house_number.set(args[:companies_house_number]) if args.key?(:companies_house_number)
    submit_button.click
  end

end
