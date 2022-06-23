class PaymentConfirmationPage < BasePage

  element(:confirm, "#confirm")
  element(:cancel, "#cancel-payment")
  element(:return, "#return-url")

  def submit(_args = {})
    confirm.click
  end

end
