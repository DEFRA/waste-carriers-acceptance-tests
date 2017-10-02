class BusinessDetailsPage < SitePrism::Page

  # Business details
  element(:company_name, "#registration_companyName")
  element(:postcode, "#sPostcode")
  element(:find_address, "#find_address")
  element(:results_dropdown, "select#registration_selectedAddress")

  element(:submit_button, "input[value='Continue']")

  def submit(args = {})
    company_name.set(args[:company_name]) if args.key?(:company_name)
    postcode.set(args[:postcode]) if args.key?(:postcode)
    find_address.click
    results_dropdown.select(args[:result]) if args.key?(:result)

    submit_button.click
  end

end
