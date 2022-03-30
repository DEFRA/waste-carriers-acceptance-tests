class AddressLookupPage < BasePage

  # Use this for all company and contact addresses on front/back office.

  # Initial postcode selection:
  element(:postcode, "input[id*='postcode-form-temp']")

  # Once result is shown:
  element(:change_postcode, "a[href*='company-address/back']")
  element(:results_dropdown, "select[id*='address_uprn']")
  element(:manual_address, "a[href*='skip_to_manual_address']")
  element(:submit_button, "[type='submit']")

  def submit_valid_address(_args = {})
    enter_postcode("BS1 5AH")
    # This uses a partial match, so works regardless of whether the address is Natural England or Environment Agency
    results_dropdown.select("HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH")
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
    submit_button.click
  end

end
