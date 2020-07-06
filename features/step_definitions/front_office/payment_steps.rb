Given(/^I complete my renewal up to the payment page$/) do
  # Adding "reject" in the company name ensures payment will be rejected by the Worldpay mock here, if activated:
  @business_name ||= "Renewal with rejected payment"
  agree_to_renew_in_england
  @journey.confirm_business_type_page.submit
  @journey.tier_check_page.submit(choice: :check_tier)
  select_random_upper_tier_options("existing")
  @renewals_app.renewal_information_page.submit
  submit_business_details(@business_name)
  submit_company_people
  submit_convictions("no convictions")
  submit_existing_contact_details
  check_your_answers
  @journey.registration_cards_page.submit
  expect(@journey.payment_summary_page.current_url).to include "/payment-summary"
end

When(/^I have my credit card payment rejected$/) do
  @journey.payment_summary_page.submit(choice: :card_payment)
  submit_invalid_card_payment unless mocking_enabled?
  expect(@journey.payment_summary_page.error_summary).to have_text("Your payment has been refused.")
end

When(/^I cancel my credit card payment$/) do
  @journey.payment_summary_page.submit(choice: :card_payment)
  @journey.worldpay_payment_page.cancel_payment unless mocking_enabled?
  expect(@journey.payment_summary_page.error_summary).to have_text("Your attempt to pay has been cancelled.")
end

Then(/^(?:I can pay with another card|I try my credit card payment again)$/) do
  @journey.payment_summary_page.submit(choice: :card_payment)
  submit_valid_card_payment
end

When(/^I choose to pay by bank transfer$/) do
  @journey.payment_summary_page.submit(choice: :bank_transfer_payment)
  @renewals_app.bank_transfer_page.submit
end
