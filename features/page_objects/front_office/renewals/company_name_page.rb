class CompanyNamePage < SitePrism::Page

  # whats the name of the company?
  element(:company_name, "#company_name_form_company_name")
  element(:heading, :xpath, "//h1[contains(text(), 'the name of the')]")
  element(:submit_button, ".button")

  def submit(args = {})
    company_name.set(args[:company_name]) if args.key?(:company_name)

    submit_button.click
  end

end
