class CompanyNamePage < SitePrism::Page

  # What's the name of the company?
  element(:company_name, "#registration_companyName")

  element(:submit_button, "input[value='Continue']")

  def submit(args = {})
    company_name.set(args[:company_name]) if args.key?(:company_name)

    submit_button.click
  end

end