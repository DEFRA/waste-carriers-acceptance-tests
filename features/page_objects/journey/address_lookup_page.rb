class AddressLookupPage < SitePrism::Page

  # Use this for all RENEWAL functionality, for company and contact addresses.
  # Don't use for registrations until tech debt is complete.
  # This is a merge of the following pages to be consistent with WEX:
  # - renewals > business_address_page
  # - renewals > contact_address_page
  # - renewals > post_code_page
  # - renewals > contact_postcode_page

  element(:back_link, ".link-back")
  element(:heading, ".heading-large")

  # Initial postcode selection:
  element(:postcode, "input[id*='postcode_form_temp']")
  element(:find_address_button, "input[value='Find address']")

  # Once result is shown:
  element(:change_postcode, "a[href*='company-address/back']")
  element(:results_dropdown, "select[id*='address_uprn']")
  element(:manual_address, "a[href*='skip_to_manual_address']")
  element(:submit_button, ".button")

  def submit_valid_address(_args = {})
    enter_postcode("BS1 5AH")
    results_dropdown.select("ENVIRONMENT AGENCY, HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH")
    submit_button.click
  end

  def submit_invalid_address(_args = {})
    enter_postcode("BS1 9XX")
    manual_address.click
  end

  def choose_manual_address(_args = {})
    enter_postcode("BS1 5AH")
    manual_address.click
  end

  def enter_postcode(postcode_entry)
    postcode.set(postcode_entry)
    find_address_button.click
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
