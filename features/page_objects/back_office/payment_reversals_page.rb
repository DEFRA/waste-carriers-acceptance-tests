class PaymentReversalsPage < SitePrism::Page

  # Reversals

  element(:select_payment, :xpath, ".//*[@id='reversal-index']/table/tbody/tr/td[5]/a")

end
