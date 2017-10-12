class WorldpayCardDetailsPage < SitePrism::Page

  # Secure Payment Page
  element(:card_number, "#cardNoInput")
  element(:security_code, "#cardCVV")
  element(:expiry_month, "select[name='cardExp.month']")
  element(:expiry_year, "select[name='cardExp.year']")
  element(:cardholder_name, "#name")

  element(:pay, "#op-PMMakePayment")

  # Used for test simulation
  element(:submit_button, "input[value='Submit']")

  def submit(args = {})
    card_number.set(args[:card_number]) if args.key?(:card_number)
    security_code.set(args[:security_code]) if args.key?(:security_code)
    expiry_month.select(args[:expiry_month]) if args.key?(:expiry_month)
    expiry_year.select(args[:expiry_year]) if args.key?(:expiry_year)
    cardholder_name.set(args[:cardholder_name]) if args.key?(:cardholder_name)
    pay.click
    submit_button.click
  end

end
