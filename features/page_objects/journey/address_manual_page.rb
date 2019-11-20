class AddressManualPage < SitePrism::Page

  # New manual address page. Replaces:
  # - (back/front) renewals > manual_address_page
  # - (back/front) renewals > contact_manual_address_page

  element(:change_postcode, "a[href*='address-manual/back']")
  element(:house_number, "input[id*='address_house_number']")
  element(:address_line_one, "input[id*='address_line_1']")
  element(:address_line_two, "input[id*='address_line_2']")
  element(:city, "input[id*='address_town_city']")

  # The following only appear in certain journeys such as international renewals:
  element(:postcode, "input[id*='address_postcode']")
  element(:country, "input[id*='address_country']")

  element(:submit_button, ".button")

  def submit(args = {})
    house_number.set(args[:house_number]) if args.key?(:house_number)
    address_line_one.set(args[:address_line_one])
    address_line_two.set(args[:address_line_two]) if args.key?(:address_line_two)
    city.set(args[:city]) if args.key?(:city)
    postcode.set(args[:postcode]) if args.key?(:postcode)
    country.set(args[:country]) if args.key?(:country)

    submit_button.click
  end

  # Page objects from company address flow:
  # Change postcode link: #new_company_address_manual_form a OR /fo/company-address-manual/back
  # House number field: #company_address_manual_form_company_address_house_number
  # Address line 1 field: #company_address_manual_form_company_address_address_line_1
  # Address line 2 field: #company_address_manual_form_company_address_address_line_2
  # Town or city field: #company_address_manual_form_company_address_town_city
  # Postcode (doesn't always appear): #contact_address_manual_form_contact_address_postcode
  # Country (doesn't always appear): #contact_address_manual_form_contact_address_country
  # Continue button: .button

end
