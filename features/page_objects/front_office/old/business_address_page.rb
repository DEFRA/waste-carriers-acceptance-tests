class BusinessAddressPage < SitePrism::Page

  # Merge this into journey > address_lookup_page when registration tech debt is complete

  # whats the address?

  element(:find_address, "#find_address")
  element(:results_dropdown, "select#registration_selectedAddress")

  element(:submit_button, "input[value='Continue']")

  def submit(args = {})
    find_address.click
    results_dropdown.select(args[:result]) if args.key?(:result)

    submit_button.click
  end

end
