class BusinessAddressPage < SitePrism::Page

  # whats the address?

  element(:find_address, "#find_address")
  element(:results_dropdown, "select#company_address_form_temp_address")
  element(:manual_address, "a[href*='skip_to_manual_address']")
  element(:submit_button, "input[value='Continue']")

  def submit(args = {})
    wait_until_results_dropdown_visible(5)
    results_dropdown.select(args[:result]) if args.key?(:result)

    submit_button.click
  end

  def manual_address_submit(_args = {})
    wait_until_manual_address_visible(5)
    manual_address.click
  end

end
