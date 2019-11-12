class PostCodePage < SitePrism::Page

  # Consider merging this with contact_postcode_page to allow reusable functions
  # whats the  address?

  element(:postcode, "#company_postcode_form_temp_company_postcode")

  element(:heading, :xpath, "//h1[contains(text(), 'the address of the')]")
  element(:submit_button, ".button")

  def submit(args = {})
    postcode.set(args[:postcode]) if args.key?(:postcode)

    submit_button.click
  end

end
