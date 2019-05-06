# frozen_string_literal: true

class OrderPage < SitePrism::Page

  # Payment summary
  element(:copy_cards, "#registration_copy_cards")

  element(:registration_charge, "#registration_registration_fee")
  element(:edit_charge, "#edit_charge")
  element(:copy_card_charge, "#registration_copy_card_fee")
  element(:total_charge, "#registration_total_fee")

  element(:card_payment, "#registration_payment_type_world_pay")
  element(:bank_transfer_payment, "#registration_payment_type_bank_transfer")

  element(:submit_button, "#proceed_to_payment")

  def submit(args = {})
    copy_cards.set(args[:copy_card_number]) if args.key?(:copy_card_number)

    # As long as the arg passed in matches the name of an element we can simply
    # invoke the element using ruby's send() method. In this way we can avoid
    # overly long case/switch statements that check the value of the arg to
    # determine which element to select
    send(args[:choice]).select_option

    submit_button.click
  end

end
