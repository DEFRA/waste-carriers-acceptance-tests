class WorldpayCardDetailsPage < SitePrism::Page

  # Secure Payment Page
  element(:card_number, "#cardNoInput")
  element(:security_code, "#cardCVV")
  element(:expiry_month, "select[name='cardExp.month']")
  element(:expiry_year, "select[name='cardExp.year']")
  element(:cardholder_name, "#name")

  element(:pay, "#op-PMMakePayment")

  # Used for test simulation
  element(:submit_button_renew, "input[type='submit']")
  element(:submit_button, "input[value='Submit']")

  # Test credit card details

  # Card numbers
  @mastercard_number = "5100080000000000"
  @visacard_number = "4917610000000000"
  @maestrocard_number = "6759649826438453"

  # Card holder names
  @authorised = "3d.authorised"
  @refused = "3d.refused"
  @error = "3d.error"

  # Security codes (CSV)
  @approved = "555"
  @failed = "444"

  element(:submit_button, "input[type='submit']")

  def submit(_args = {})
    submit_button.click
  end

end
