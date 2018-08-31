class PaymentSummaryPage < SitePrism::Page

  # Payment summary
  element(:card_payment, "#payment_summary_form_temp_payment_method_card", visible: false)
  element(:bank_transfer_payment, "#payment_summary_form_temp_payment_method_bank_transfer", visible: false)

  element(:charge, "#registration_registration_fee")
  element(:heading, :xpath, "//h1[contains(text(), 'Payment summary')]")
  element(:submit_button, "input[type='submit']")
  element(:back_link, "a[href*='back']")

  def submit(args = {})
    case args[:choice]
    when :card_payment
      card_payment.click
    when :bank_transfer_payment
      bank_transfer_payment.click
    end
    submit_button.click
  end

end
