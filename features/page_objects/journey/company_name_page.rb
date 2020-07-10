class CompanyNamePage < SitePrism::Page

  # whats the name of the company?
  element(:error_summary, ".error-summary")
  element(:company_name, "#company_name_form_company_name")
  element(:heading, ".heading-large")
  element(:submit_button, ".button")

  def submit(args = {})
    company_name.set(args[:company_name]) if args.key?(:company_name)

    submit_button.click
  end

end
