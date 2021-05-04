# Functions that can be reused to help with payments

def submit_valid_card_payment
  sleep(3)
  # The return clause is called if WorldPay mocking is in place - if so, the payment is skipped and marked as complete.
  worldpay_page_is_shown = @journey.worldpay_payment_page.has_test_mode_text?
  return unless worldpay_page_is_shown

  expect(@journey.worldpay_payment_page.test_mode_text).to have_text("Test Mode - This is not a live transaction")

  @journey.worldpay_payment_page.submit(
    card_number: "6759649826438453",
    cardholder_name: "3d.authorised",
    expiry_month: "12",
    expiry_year: next_year,
    security_code: "555"
  )
  # We don't always know when WorldPay will request an additional 3D secure verification.
  # The next function detects whether it has been requested, and simulates the verification result.
  verify_cardholder if @journey.worldpay_payment_page.has_verification_heading?
end

def submit_invalid_card_payment
  sleep(3)
  expect(@journey.worldpay_payment_page.test_mode_text).to have_text("Test Mode - This is not a live transaction")
  @journey.worldpay_payment_page.submit(
    card_number: "6759649826438453",
    cardholder_name: "3d.refused",
    expiry_month: "12",
    expiry_year: next_year,
    security_code: "555"
  )
  fail_cardholder if @journey.worldpay_payment_page.has_verification_heading?
end

def verify_cardholder
  @journey.worldpay_payment_page.verify(response: "Cardholder authenticated")
end

def fail_cardholder
  @journey.worldpay_payment_page.verify(response: "Cardholder failed authentication")
end
