class PostCodePage < SitePrism::Page

  # whats the  address?

  element(:postcode, "#company_postcode_form_temp_postcode")

  element(:heading, :xpath, "//h1[contains(text(), 'the address of the')]")
  element(:submit_button, "input[type='submit']")

  def submit(args = {})
    wait_for_postcode
    postcode.set(args[:postcode]) if args.key?(:postcode)

    submit_button.click
  end

end
