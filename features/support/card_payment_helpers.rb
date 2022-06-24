# Functions that can be reused to help with payments

def submit_card_payment
  return if mocking_enabled?

  expect(@journey.payment_page.payment_description).to have_text(@reg_number)
  @journey.payment_page.submit(
    card_number: "4444333322221111",
    cardholder_name: "Mr Happy",
    expiry_month: "12",
    expiry_year: next_year,
    security_code: "555",
    email: "simulate-delivered@notifications.service.gov.uk",
    address_line_one: "1 payment lane",
    address_line_two: "Teston",
    city: "Testville",
    postcode: "TS11 9XX"
  )
  @journey.payment_confirmation_page.submit
end

def submit_invalid_card_payment
  @journey.payment_page.submit(
    card_number: "4000000000000002",
    cardholder_name: "Mr Sad",
    expiry_month: "12",
    expiry_year: next_year,
    security_code: "555",
    email: "simulate-delivered@notifications.service.gov.uk",
    address_line_one: "1 payment lane",
    address_line_two: "Teston",
    city: "Testville",
    postcode: "TS11 9XX"
  )
end
