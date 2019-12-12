# Functions that can be reused to help with payments

def submit_valid_card_payment
  sleep(3)
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
  expect(@journey.worldpay_payment_page.test_mode_text).to have_text("Test Mode - This is not a live transaction")
  @journey.worldpay_payment_page.submit(
    card_number: "6759649826438453",
    cardholder_name: "3d.refused",
    expiry_month: "12",
    expiry_year: next_year,
    security_code: "555"
  )
  verify_cardholder if @journey.worldpay_payment_page.has_verification_heading?
end

def verify_cardholder
  @journey.worldpay_payment_page.verify(response: "Cardholder authenticated")
end
