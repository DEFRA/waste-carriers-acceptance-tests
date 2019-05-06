# frozen_string_literal: true

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

  def submit(args = {})
    card_number.set(args[:number]) if args.key?(:number)
    security_code.set(args[:security_code]) if args.key?(:security_code)
    cardholder_name.set(args[:holder_name]) if args.key?(:holder_name)
    expiry_month.select(args[:expiry_month]) if args.key?(:expiry_month)
    expiry_year.select(args[:expiry_year]) if args.key?(:expiry_year)

    pay.click
  end

end
