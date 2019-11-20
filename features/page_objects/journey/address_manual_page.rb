class AddressManualPage < SitePrism::Page

  # Use this for all manual addresses for renewals

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

end
