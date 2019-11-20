class AddressPostcodePage < SitePrism::Page

  # Use this for all new renewal functionality.
  # This is a merge of the following pages to be consistent with WEX:
  # - post_code_page
  # - contact_postcode_page
  # Move this to journey app once the registration journey aligns with renewals.

  # TODO: Change all calls to renewal postcode pages

  # Consider merging this (and its functions) with address_lookup_page as per WEX.
  # This would involve rewriting the calls to each function and could get messy without small, reusable functions.
  # List of page objects is in address_lookup_page.

  element(:heading, ".heading-large")
  element(:postcode, "input[id*='postcode_form_temp']")
  element(:submit_button, "input[value='Find address']")

  def submit(args = {})
    postcode.set(args[:postcode]) if args.key?(:postcode)
    submit_button.click
  end

end
