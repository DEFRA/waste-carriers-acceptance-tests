class PostCodePage < SitePrism::Page

  # whats the  address?

  element(:postcode, "#company_postcode_form_temp_postcode")
  element(:manual_address, "a[href*='skip_to_manual_address']")

  element(:submit_button, "input[type='submit']")

  def submit(args = {})
    postcode.set(args[:postcode]) if args.key?(:postcode)

    submit_button.click
  end

end
