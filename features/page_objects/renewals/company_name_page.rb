class CompanyNamePage < SitePrism::Page

  # whats the name of the company?
  element(:company_name, "#registration_companyName")
  element(:heading, :xpath, "//h1[contains(text(), 'the name of the')]")
  element(:submit_button, "input[value='Continue']")

  def submit(args = {})
    wait_for_company_name
    company_name.set(args[:company_name]) if args.key?(:company_name)

    submit_button.click
  end

end
