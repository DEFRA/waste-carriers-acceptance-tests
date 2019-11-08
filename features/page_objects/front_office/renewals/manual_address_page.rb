class ManualAddressPage < SitePrism::Page

  # whats the address?

  element(:change_postcode, "a[href^='/company-address-manual/back']")
  element(:house_number, "#company_address_manual_form_company_address_house_number")
  element(:address_line_one, "#company_address_manual_form_company_address_address_line_1")
  element(:address_line_two, "#company_address_manual_form_company_address_address_line_2")
  element(:city, "#company_address_manual_form_company_address_town_city")

  # Next line does not appear for renewals. Is it required here?
  element(:country, "input[id$='address_manual_form_country']")

  element(:submit_button, ".button")

  def submit(args = {})
    house_number.set(args[:house_number]) if args.key?(:house_number)
    address_line_one.set(args[:address_line_one]) if args.key?(:address_line_one)
    address_line_two.set(args[:address_line_two]) if args.key?(:address_line_two)
    city.set(args[:city]) if args.key?(:city)
    country.set(args[:country]) if args.key?(:country)

    submit_button.click
  end

end
