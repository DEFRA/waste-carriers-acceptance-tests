class AddressLookupPage < SitePrism::Page

  # Use this for all new RENEWAL functionality.
  # Don't use for registrations until tech debt is complete.
  # This is a merge of the following pages to be consistent with WEX:
  # - renewals > business_address_page
  # - contact_address_page
  # Move this to journey app once the registration journey aligns with renewals.

  element(:back_link, ".link-back")
  element(:heading, ".heading-large")

  # Suspect :address is not used. Delete this if tests pass:
  # element(:address, "#contact/company_address_form_temp_address")

  # find_address is used from back_app.
  element(:find_address, "#find_address")
  element(:change_postcode, "a[href*='company-address/back']")
  element(:results_dropdown, "select[id*='address_uprn']")
  element(:manual_address, "a[href*='skip_to_manual_address']")
  element(:submit_button, ".button")

  def submit(args = {})
    results_dropdown.select(args[:result]) if args.key?(:result)
    submit_button.click
  end

  def manual_address_submit(_args = {})
    manual_address.click
  end

  # All address page objects for reference while I'm merging page objects:

  # COMPANY ADDRESS LOOKUP
  # Postcode: #company_postcode_form_temp_company_postcode
  # Find address button: .button
  # Change postcode link: "Change postcode" OR .postcode+ a OR /fo/company-address/back
  # Address dropdown: #company_address_form_company_address_uprn
  # Can't find address link:
  # - "I cannot find the address in the list"
  # - OR .form-group+ .form-group a
  # - OR /fo/company-address/skip-to-manual-address
  # Continue button: .button

  # CONTACT ADDRESS LOOKUP
  # Back link: .link-back
  # Postcode: #contact_postcode_form_temp_contact_postcode
  # Find address: .button
  # Change postcode: "Change postcode" OR .postcode+ a OR /fo/contact-address/back
  # Address dropdown: #contact_address_form_contact_address_uprn
  # Can't find address link: Same as company address except link is /fo/contact-address/skip-to-manual-address
  # Continue button: .button

end
