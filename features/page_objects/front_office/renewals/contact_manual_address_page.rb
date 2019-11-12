class ContactManualAddressPage < SitePrism::Page

  # whats the address?

  # Consider merging this with manual_address_page as per WEX

  element(:change_postcode, "a[href^='/contact-address-manual/back']")
  element(:house_number, "#contact_address_manual_form_contact_address_house_number")
  element(:address_line_one, "#contact_address_manual_form_contact_address_address_line_1")
  element(:address_line_two, "#contact_address_manual_form_contact_address_address_line_2")
  element(:city, "#contact_address_manual_form_contact_address_town_city")

  # The following only appear in certain journeys such as front office renewals:
  element(:postcode, "#contact_address_manual_form_contact_address_postcode")
  element(:country, "#contact_address_manual_form_contact_address_country")

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

end
