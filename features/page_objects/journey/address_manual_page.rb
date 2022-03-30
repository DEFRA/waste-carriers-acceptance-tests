class AddressManualPage < BasePage

  # Use this for all manual addresses for renewals

  element(:change_postcode, "a[href*='address-manual/back']")
  element(:house_number, "[id$='address-house-number-field']")
  element(:address_line_one, "[id$='address-address-line-1-field']")
  element(:address_line_two, "[id$='address-address-line-2-field']")
  element(:city, "[id$='address-town-city-field']")

  # The following only appear in certain journeys such as international renewals:
  element(:postcode, "input[id$='address-postcode-field")
  element(:country, "input[id$='address-country-field']")

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
