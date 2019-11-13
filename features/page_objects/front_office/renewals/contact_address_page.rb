class ContactAddressPage < SitePrism::Page

  # Consider merging this with business_address_page as per WEX.

  # whats the address of the person we should contact?
  element(:change_postcode, "a[href*='skip_to_manual_address']")
  element(:address, "#contact_address_form_temp_address")
  element(:results_dropdown, "#contact_address_form_contact_address_uprn")
  element(:manual_address, "a[href*='contact-address']")
  element(:submit_button, ".button")

  def submit(args = {})
    results_dropdown.select(args[:result]) if args.key?(:result)
    submit_button.click
  end

end
