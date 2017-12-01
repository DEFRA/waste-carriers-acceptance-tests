class LimitedCompanyNumberPage < SitePrism::Page

  # Business details
  element(:companies_house_number, "#registration_company_no")

  element(:submit_button, "input[value='Continue']")

  def submit(args = {})
    companies_house_number.set(args[:companies_house_number]) if args.key?(:companies_house_number)

    submit_button.click
  end

end
