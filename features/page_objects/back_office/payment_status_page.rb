class PaymentStatusPage < SitePrism::Page

  # Payment status
  element(:enter_payment, "#enterPayment")
  element(:write_off_large, "#writeOffLarge")
  element(:reversals, "#reversals")
  element(:adjustments, "#adjustments")

  element(:payment_history_amount, :xpath, ".//*[@id='payment_history_table']/tbody/tr/td[4]")

  element(:payment_status, :xpath, ".//*[@id='balance_table']/tbody/tr/td[1]")
  element(:balance_due, "#balanceDue")

end
