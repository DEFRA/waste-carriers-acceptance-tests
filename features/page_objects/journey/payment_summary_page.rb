class PaymentSummaryPage < BasePage

  # Payment summary

  element(:card_payment, "input[value='card']+ .govuk-radios__label")
  element(:receipt_email_field, "input[id^='payment-summary-form-card-confirmation-email-field']")
  element(:bank_transfer_payment, "input[value='bank_transfer']+ .govuk-radios__label")

  def submit(args = {})
    case args[:choice]
    when :card_payment
      card_payment.click
      receipt_email_field.set(args[:email]) if args.key?(:email)
    when :bank_transfer_payment
      bank_transfer_payment.click
    end
    submit_button.click
  end

end
