class CardsOrderPage < BasePage

  # Order registration cards for CBDU1

  element(:contact_address, ".panel")
  element(:number_of_cards_form, "#copy_cards_form_temp_cards")

  def submit(args = {})
    number_of_cards_form.set(args[:number_of_cards]) if args.key?(:number_of_cards)
    submit_button.click
  end

end
