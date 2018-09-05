class ContactPostCodePage < SitePrism::Page

  # whats the  address?

  element(:postcode, "#contact_postcode_form_temp_contact_postcode")
  element(:manual_address, "a[href*='skip_to_manual_address']")
  element(:heading, :xpath, "//h1[contains(text(), 'the address of the')]")
  element(:submit_button, "input[type='submit']")

  def submit(args = {})
    postcode.set(args[:postcode]) if args.key?(:postcode)

    submit_button.click
  end

end
