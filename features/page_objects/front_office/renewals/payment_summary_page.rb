class PaymentSummaryPage < SitePrism::Page

  # Payment summary
  element(:back_link, "a[href*='back']")
  element(:heading, :xpath, "//h1[contains(text(), 'Payment summary')]")

  element(:card_payment, "input[value='card']", visible: false)
  element(:bank_transfer_payment, "input[value='bank_transfer']", visible: false)

  element(:charge, "#registration_registration_fee")
  element(:submit_button, ".button")

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
