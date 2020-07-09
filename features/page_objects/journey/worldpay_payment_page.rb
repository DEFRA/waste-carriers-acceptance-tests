class WorldpayPaymentPage < SitePrism::Page

  # As of Nov 2019, this is the new combined WorldPay payment page.

  # New payment page
  element(:heading, "#showOrderSummaryDesktop")
  element(:test_mode_text, ".error-hint")
  element(:card_number, "#cardNumber")
  element(:cardholder_name, "#cardholderName")
  element(:expiry_month, "#expiryMonth")
  element(:expiry_year, "#expiryYear")
  element(:security_code, "#securityCode")
  element(:cancel_payment_button, "#cancelButton")
  element(:make_payment_button, "#submitButton")

  element(:verification_heading, ".title3Ds")
  element(:verification_iframe, ".content-iframe")
  element(:verification_select_response, "select")
  element(:verification_submit_response, ".lefty")

  element(:cancel_payment_no_button, "#exitPaymentNoJsOff")
  element(:cancel_payment_yes_button, "#exitPaymentYesJsOff")

  def submit(args = {})
    card_number.set(args[:card_number]) if args.key?(:card_number)
    cardholder_name.set(args[:cardholder_name]) if args.key?(:cardholder_name)
    expiry_month.set(args[:expiry_month]) if args.key?(:expiry_month)
    expiry_year.set(args[:expiry_year]) if args.key?(:expiry_year)
    security_code.set(args[:security_code]) if args.key?(:security_code)
    click(make_payment_button)
  end

  def verify(args = {})
    # Use this to verify a user if an extra 3D Verification prompt comes up.
    # Available responses are:
    # - Not identified. No XID received
    # - The error code is valid. It is acceptable to proceed to authorisation
    # - Payment cancelled. The order does not proceed to authorisation.
    # - Cardholder authenticated
    # - Identified. No XID received
    # - Authentication offered but not used
    # - Response validation failed. The order does not proceed to authorisation.
    # - Cardholder failed authentication
    # - The error code is invalid. The order does not proceed to authorisation.
    within_frame verification_iframe do
      sleep(6) # as the 3D simulator can take time to load
      verification_select_response.select(args[:response]) if args.key?(:response)
      verification_submit_response.click
    end
  end

  def cancel_payment(_args = {})
    cancel_payment_button.click
    cancel_payment_yes_button.click
  end

end
