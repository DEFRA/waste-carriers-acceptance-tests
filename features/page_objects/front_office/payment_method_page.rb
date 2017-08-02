class PaymentMethodPage < SitePrism::Page

  # Choose how you want to pay
  element(:card_payment, "#paymentCard")
  element(:bacs_payment, "#paymentBACS")
  element(:cheque_payment, "#paymentCheque")

  element(:submit_button, "input[type='Submit']")

  def submit(args = {})
    case args[:choice]
    when :card
      card_payment.select_option
    when :bacs
      bacs_payment.select_option
    when :cheque
      cheque_payment.select_option
    end

    submit_button.click
  end

end
