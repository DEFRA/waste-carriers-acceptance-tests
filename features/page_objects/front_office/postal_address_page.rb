class PostalAddressPage < SitePrism::Page

  # Who should we write to?
  element(:first_name, "#address_firstName")
  element(:last_name, "#address_lastName")
  element(:house_number, "#address_houseNumber")
  element(:address_line_one, "#address_addressLine1")
  element(:address_line_two, "#address_addressLine2")
  element(:address_line_three, "#address_addressLine3")
  element(:address_line_four, "#address_addressLine4")
  element(:town, "#address_townCity")
  element(:post_code, "#address_postcode")
  element(:country, "#address_country")

  element(:submit_button, "input[type='Submit']")

  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/CyclomaticComplexity
  # rubocop:disable Metrics/PerceivedComplexity
  def submit(args = {})
    first_name.set(args[:first_name]) if args.key?(:first_name)
    last_name.set(args[:last_name]) if args.key?(:last_name)
    house_number.set(args[:house_number]) if args.key?(:house_number)
    address_line_one.set(args[:address_line_one]) if args.key?(:address_line_one)
    address_line_two.set(args[:address_line_two]) if args.key?(:address_line_two)
    address_line_three.set(args[:address_line_three]) if args.key?(:address_line_three)
    address_line_four.set(args[:address_line_four]) if args.key?(:address_line_four)
    town.set(args[:town]) if args.key?(:town)
    post_code.set(args[:post_code]) if args.key?(:post_code)
    country.set(args[:country]) if args.key?(:country)

    submit_button.click
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/CyclomaticComplexity
  # rubocop:enable Metrics/PerceivedComplexity
end
