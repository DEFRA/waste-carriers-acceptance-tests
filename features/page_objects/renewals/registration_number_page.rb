class RegistrationNumberPage < SitePrism::Page

  # Business details
  element(:companies_house_number, "#registration_number_form_company_no")
  element(:heading, :xpath, "//h1[contains(text(), 'registration number')]")
  element(:submit_button, "input[type='submit']")

  def submit(args = {})
    wait_for_companies_house_number
    companies_house_number.set(args[:companies_house_number]) if args.key?(:companies_house_number)

    submit_button.click
  end

end
