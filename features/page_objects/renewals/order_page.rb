class OrderPage < SitePrism::Page

  # Payment summary
  element(:copy_cards, "#registration_copy_cards")
  element(:card_payment, "#registration_payment_type_world_pay")
  element(:bank_transfer_payment, "#registration_payment_type_bank_transfer")
  element(:edit_charge, "#edit_charge")
  element(:charge, "#registration_registration_fee")

  element(:submit_button, "input[type='submit']")

  def submit(args = {})
    copy_cards.set(args[:copy_card_number]) if args.key?(:copy_card_number)
    case args[:choice]
    when :card_payment
      card_payment.click
    when :bank_transfer_payment
      bank_transfer_payment.click
    end
    submit_button.click
  end

end
