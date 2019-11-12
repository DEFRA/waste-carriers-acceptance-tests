class ContactPostCodePage < SitePrism::Page

  # Consider merging this with contact_address_page and business_address_page to allow reuse of address functions

  # whats the address?

  element(:postcode, "#contact_postcode_form_temp_contact_postcode")
  element(:manual_address, "a[href*='skip_to_manual_address']")
  element(:heading, :xpath, "//h1[contains(text(), 'the address of the')]")
  element(:submit_button, ".button")

  def submit(args = {})
    postcode.set(args[:postcode]) if args.key?(:postcode)

    submit_button.click
  end

end
