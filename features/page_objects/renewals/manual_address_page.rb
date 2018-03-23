class ManualAddressPage < SitePrism::Page

  # whats the address?

  element(:change_postcode, "a[href^='/company-address-manual/back']")
  element(:house_number, "input[id$='address_manual_form_house_number']")
  element(:address_line_one, "input[id$='address_manual_form_address_line_1']")
  element(:address_line_two, "input[id$='address_manual_form_address_line_2']")
  element(:city, "input[id$='address_manual_form_town_city']")
  element(:country, "input[id$='address_manual_form_country']")

  element(:submit_button, "input[value='Continue']")

  def submit(args = {})
    wait_until_house_number_visible(5)
    house_number.set(args[:house_number]) if args.key?(:house_number)
    address_line_one.set(args[:address_line_one]) if args.key?(:address_line_one)
    address_line_two.set(args[:address_line_two]) if args.key?(:address_line_two)
    city.set(args[:city]) if args.key?(:city)
    country.set(args[:country]) if args.key?(:country)

    submit_button.click
  end

end
