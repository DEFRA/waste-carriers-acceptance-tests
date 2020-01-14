class CardsOrderPage < SitePrism::Page

  # Order registration cards for CBDU1

  element(:error_summary, ".error-summary")
  element(:heading, ".heading-large")

  element(:contact_address, ".panel")
  element(:number_of_cards_form, "#copy_cards_form_temp_cards")
  element(:submit_button, ".button")

  def submit(args = {})
    number_of_cards_form.set(args[:number_of_cards]) if args.key?(:number_of_cards)
    submit_button.click
  end

end
