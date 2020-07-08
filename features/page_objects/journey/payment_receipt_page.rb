class PaymentReceiptPage < SitePrism::Page

  # Where should we send payment receipts?

  element(:back_link, "a[href*='back']")
  element(:error_summary, ".error-summary")
  element(:heading, ".heading-large")

  element(:receipt_email_field, "#receipt_email_form_receipt_email")
  element(:submit_button, ".button")

  def submit(args = {})
    receipt_email_field.set(args[:email]) if args.key?(:email)
    submit_button.click
  end

end
