class ContactAddressPage < SitePrism::Page

  # whats the address of the person we should contact?
  element(:change_postcode, "a[href*='skip_to_manual_address']")
  element(:address, "#contact_address_form_temp_address")
  element(:results_dropdown, "select#contact_address_form_temp_address")
  element(:manual_address, "a[href*='contact-address']")
  element(:submit_button, "input[value='Continue']")

  def submit(args = {})
    results_dropdown.select(args[:result]) if args.key?(:result)
    submit_button.click
  end

end
