class CardsOrderPage < SitePrism::Page

  # Order registration cards for CBDU1

  element(:error_summary, ".govuk-error-summary__body")
  element(:heading, "h1")

  element(:contact_address, ".panel")
  element(:number_of_cards_form, "#copy_cards_form_temp_cards")
  element(:submit_button, "[type='submit']")

  def submit(args = {})
    number_of_cards_form.set(args[:number_of_cards]) if args.key?(:number_of_cards)
    submit_button.click
  end

end
