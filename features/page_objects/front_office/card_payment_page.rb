class CardPaymentPage < SitePrism::Page

  # Who should we contact about this application?
  element(:card_number, "#card-number")
  element(:expiry_month, "#exp-month")
  element(:expiry_year, "#exp-year")
  element(:full_name, "#full-name")
  element(:security_code, "#security-number")
  element(:building_name, "#building-and-street-name")
  element(:building_and_street, "#building-and-street")
  element(:town_or_city, "#town-or-city")
  element(:postcode, "#postcode")
  element(:email, "#email-address")

  element(:submit_button, "input[type='Submit']")

  def submit(args = {})
    card_details(args)
    address_details(args)

    email.set(args[:email]) if args.key?(:email)

    submit_button.click
  end

  def card_details(args = {})
    card_number.set(args[:card_number]) if args.key?(:card_number)
    expiry_month.set(args[:expiry_month]) if args.key?(:expiry_month)
    expiry_year.set(args[:expiry_year]) if args.key?(:expiry_year)
    full_name.set(args[:full_name]) if args.key?(:full_name)
    security_code.set(args[:security_code]) if args.key?(:security_code)
  end

  def address_details(args = {})
    building_name.set(args[:building_name]) if args.key?(:building_name)
    building_and_street.set(args[:building_and_street]) if args.key?(:building_and_street)
    town_or_city.set(args[:town_or_city]) if args.key?(:town_or_city)
    postcode.set(args[:postcode]) if args.key?(:postcode)
  end

end
