class BusinessDetailsPage < SitePrism::Page

  # Business details
  element(:companies_house_number, "#registration_company_no")
  element(:company_name, "#registration_companyName")
  element(:postcode, "#sPostcode")
  element(:find_address, "#find_address")
  element(:results_dropdown, "select#registration_selectedAddress")

  element(:submit_button, "#continue")

  def submit(args = {})
    companies_house_number.set(args[:registration_number]) if args.key?(:registration_number)
    company_name.set(args[:operator_name]) if args.key?(:operator_name)
    postcode.set(args[:postcode]) if args.key?(:postcode)
    find_address.click
    results_dropdown.select(args[:result]) if args.key?(:result)

    submit_button.click
  end

end
