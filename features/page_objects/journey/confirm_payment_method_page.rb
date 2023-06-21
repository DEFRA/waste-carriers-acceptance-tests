class ConfirmPaymentMethodPage < BasePage

  element(:yes, "#payment-method-confirmation-form-temp-confirm-payment-method-yes-field+ .govuk-radios__label")
  element(:no, "#payment-method-confirmation-form-temp-confirm-payment-method-no-field+ .govuk-radios__label")

  def submit(args = {})
    case args[:choice]
    when :yes
      yes.click
    when :no
      no.click
    end
    submit_button.click
  end
end
