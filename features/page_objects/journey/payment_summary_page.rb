class PaymentSummaryPage < SitePrism::Page

  # Payment summary

  element(:back_link, "a[href*='back']")
  element(:error_summary, ".error-summary")
  element(:heading, ".heading-large")

  element(:card_payment, "input[value='card']", visible: false)
  element(:receipt_email_field, "#receipt_email_form_receipt_email")
  element(:bank_transfer_payment, "input[value='bank_transfer']", visible: false)

  element(:charge, "#registration_registration_fee")
  element(:submit_button, ".button")

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
