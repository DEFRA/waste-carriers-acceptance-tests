class BusinessAddressPage < SitePrism::Page

  # whats the address?

  element(:find_address, "#find_address")
  element(:results_dropdown, "select#company_address_form_temp_address")

  element(:submit_button, "input[value='Continue']")

  def submit(args = {})
    results_dropdown.select(args[:result]) if args.key?(:result)

    submit_button.click
  end

end
