class BusinessAddressPage < SitePrism::Page

  # whats the address?

  element(:find_address, "#find_address")
  element(:results_dropdown, "select#registration_selectedAddress")

  element(:submit_button, "input[value='Continue']")

  def submit(args = {})
    wait_for_find_address_visible(5)
    find_address.click
    results_dropdown.select(args[:result]) if args.key?(:result)

    submit_button.click
  end

end
