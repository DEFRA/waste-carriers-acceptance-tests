class WorldpayCardDetailsPage < SitePrism::Page

  # Secure Payment Page
  element(:card_number, "#cardNoInput")
  element(:security_code, "#cardCVV")
  element(:expiry_month, "select[name='cardExp.month']")
  element(:expiry_year, "select[name='cardExp.year']")
  element(:cardholder_name, "#name")
  element(:postcode, "#postcode")
  element(:pay, "#op-PMMakePayment")

  # Used for test simulation
  element(:submit_button, "input[type='submit']")

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

  def submit(args = {})
    card_number.set(args[:card_number]) if args.key?(:card_number)
    security_code.set(args[:security_code]) if args.key?(:security_code)
    cardholder_name.set(args[:cardholder_name]) if args.key?(:cardholder_name)
    expiry_month.select(args[:expiry_month]) if args.key?(:expiry_month)
    expiry_year.select(args[:expiry_year]) if args.key?(:expiry_year)
    postcode.set(args[:postcode]) if args.key?(:postcode)
    click(pay)
  end

end
