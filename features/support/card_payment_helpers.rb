# Functions that can be reused to help with payments
# rubocop:disable Metrics/MethodLength
def submit_card_payment
  return if mocking_enabled?
  if @journey.payment_page.heading.text.include?("We’re experiencing technical problems")
    raise("Payment error persisted")
  end

  @journey.payment_page.submit(
    card_number: "4444333322221111",
    cardholder_name: "Mr Happy",
    expiry_month: "12",
    expiry_year: next_year,
    security_code: "555",
    email: "simulate-delivered@notifications.service.gov.uk"
  )
  # MOTO payments don't require an address
  unless @app == :bo
    @journey.payment_page.submit(
      address_line_one: "1 payment lane",
      address_line_two: "Teston",
      city: "Testville",
      postcode: "TS11 9XX"
    )
  end
  @journey.payment_page.submit_payment_button.click
  @journey.payment_confirmation_page.submit
end

# rubocop:enable Metrics/MethodLength
def submit_invalid_card_payment
  @journey.payment_page.submit(
    card_number: "4000000000000002",
    cardholder_name: "Mr Sad",
    expiry_month: "12",
    expiry_year: next_year,
    security_code: "555",
    email: "simulate-delivered@notifications.service.gov.uk"
  )
  # MOTO payments don't require an address
  unless @app == :bo
    @journey.payment_page.submit(
      address_line_one: "1 payment lane",
      address_line_two: "Teston",
      city: "Testville",
      postcode: "TS11 9XX"
    )
  end
  @journey.payment_page.submit_payment_button.click
end

def submit_card_payment_with_error
  @journey.payment_page.submit(
    card_number: "4000000000000119",
    cardholder_name: "Mr error",
    expiry_month: "12",
    expiry_year: next_year,
    security_code: "555",
    email: "simulate-delivered@notifications.service.gov.uk"
  )
  # MOTO payments don't require an address
  unless @app == :bo
    @journey.payment_page.submit(
      address_line_one: "1 payment lane",
      address_line_two: "Teston",
      city: "Testville",
      postcode: "TS11 9XX"
    )
  end
  @journey.payment_page.submit_payment_button.click
end
