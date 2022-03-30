class CardsPaymentPage < BasePage

  # Payment summary

  element(:cost_table, "table")
  element(:bank_card_radio, "#copy_cards_payment_form_temp_payment_method_card", visible: false)
  element(:alternative_payment_radio, "#copy_cards_payment_form_temp_payment_method_bank_transfer", visible: false)

  def submit(args = {})
    case args[:choice]
    when :bank_card
      bank_card_radio.click
    when :alternative_payment
      alternative_payment_radio.click
    end
    submit_button.click
  end

end
