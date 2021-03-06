class CompanyNumberPage < SitePrism::Page

  # Business details

  element(:error_summary, ".error-summary")
  element(:heading, ".heading-large")

  element(:companies_house_number, "#registration_number_form_company_no")
  element(:submit_button, "input[type='submit']")

  def submit(args = {})
    companies_house_number.set(args[:companies_house_number]) if args.key?(:companies_house_number)

    submit_button.click
  end

end
