Given(/^I am on the payment page$/) do
  # Adding "reject" in the company name ensures payment will be rejected by the Worldpay mock here, if activated:
  @business_name = "Renewal with rejected payment"
  agree_to_renew_in_england
  @journey.confirm_business_type_page.submit
  @journey.tier_check_page.submit(choice: :check_tier)
  select_random_upper_tier_options("existing")
  @renewals_app.renewal_information_page.submit
  submit_business_details(@business_name)
  submit_company_people
  submit_convictions("no convictions")
  @journey.contact_name_page.submit
  @journey.contact_phone_page.submit
  @journey.contact_email_page.submit
  @journey.address_lookup_page.submit_valid_address
  check_your_answers
  @journey.registration_cards_page.submit
  expect(@renewals_app.payment_summary_page.current_url).to include "/payment-summary"
end

When(/^I have my credit card payment rejected$/) do
  # This step will not work when WorldPay mocking is in place, so commented out for now
  # @renewals_app.payment_summary_page.submit(choice: :card_payment)
  # submit_invalid_card_payment
end

When(/^I cancel my credit card payment$/) do
  # This step will not work when WorldPay mocking is in place, so commented out for now
  # @renewals_app.payment_summary_page.submit(choice: :card_payment)
  # @journey.worldpay_payment_page.cancel_payment
end

Then(/^(?:I can pay with another card|I try my credit card payment again)$/) do
  @renewals_app.payment_summary_page.submit(choice: :card_payment)
  submit_valid_card_payment
end

When(/^I can pay by bank transfer$/) do
  @renewals_app.payment_summary_page.submit(choice: :bank_transfer_payment)
  @renewals_app.bank_transfer_page.submit
end
