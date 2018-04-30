class PaymentSummaryPage < SitePrism::Page

  # Payment summary
  element(:card_payment, "#payment_summary_form_temp_payment_method_card")
  element(:bank_transfer_payment, "#payment_summary_form_temp_payment_method_bank_transfer")

  element(:charge, "#registration_registration_fee")
  element(:heading, :xpath, "//h1[contains(text(), 'Payment summary')]")
  element(:submit_button, "input[type='submit']")
  element(:back_link, "a[href*='back']")

  def submit(args = {})
    wait_for_card_payment
    find("label", text: (args[:answer])).click if args.key?(:answer)

    submit_button.click
  end

end
