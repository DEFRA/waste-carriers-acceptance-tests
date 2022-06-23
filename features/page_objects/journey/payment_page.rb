class PaymentPage < BasePage

  element(:card_number, "#card-no")
  element(:cardholder_name, "#cardholder-name")
  element(:expiry_month, "#expiry-month")
  element(:expiry_year, "#expiry-year")
  element(:security_code, "#cvc")
  element(:cancel, "#cancel-payment")
  element(:email, "#email")
  element(:address_line_one, "#address-line-1")
  element(:address_line_two, "#address-line-2")
  element(:city, "#address-city")
  element(:postcode, "#address-postcode")

  element(:submit_payment_button, "#submit-card-details")

  element(:payment_description, "#payment-description")
  element(:payment_amount, "#amount")
  # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
  def submit(args = {})
    card_number.set(args[:card_number]) if args.key?(:card_number)
    cardholder_name.set(args[:cardholder_name]) if args.key?(:cardholder_name)
    expiry_month.set(args[:expiry_month]) if args.key?(:expiry_month)
    expiry_year.set(args[:expiry_year]) if args.key?(:expiry_year)
    security_code.set(args[:security_code]) if args.key?(:security_code)
    address_line_one.set(args[:address_line_one]) if args.key?(:address_line_one)
    address_line_two.set(args[:address_line_two]) if args.key?(:address_line_two)
    city.set(args[:city]) if args.key?(:city)
    postcode.set(args[:postcode]) if args.key?(:postcode)
    email.set(args[:email]) if args.key?(:email)
    submit_payment_button.click
  end
  # rubocop:enable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity

  def cancel_payment
    cancel.click
  end

end
