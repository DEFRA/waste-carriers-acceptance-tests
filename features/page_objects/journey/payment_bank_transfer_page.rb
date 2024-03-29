class PaymentBankTransferPage < BasePage

  # Registration takes longer if you pay by bank transfer

  element(:go_back_to_payment_summary_link, "a[href*='confirm-bank-transfer/back']")
  element(:submit_button, "[type='submit']")

  def submit(_args = {})
    submit_button.click
  end

end
