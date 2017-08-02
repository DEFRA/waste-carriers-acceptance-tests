class CheckOperatorPage < SitePrism::Page

  # What's the company registration number?
  element(:company_number, "#companyRegNum")

  element(:submit_button, "input[type='Submit']")

  def submit(args = {})
    company_number.set(args[:company_number]) if args.key?(:company_number)
    submit_button.click
  end

end
