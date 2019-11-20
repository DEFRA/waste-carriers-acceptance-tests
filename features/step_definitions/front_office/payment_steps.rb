Given(/^I am on the payment page$/) do
  @renewals_app.renewal_start_page.submit
  @renewals_app.location_page.submit(choice: :england_new)
  @renewals_app.confirm_business_type_page.submit
  @renewals_app.tier_check_page.submit(choice: :check_tier)
  @renewals_app.other_businesses_page.submit(choice: :yes)
  @renewals_app.service_provided_page.submit(choice: :not_main_service)
  @renewals_app.construction_waste_page.submit(choice: :yes)
  @renewals_app.carrier_type_page.submit
  @renewals_app.renewal_information_page.submit
  @renewals_app.company_name_page.submit
  @journey_app.address_lookup_page.submit_valid_address
  people = @renewals_app.main_people_page.main_people
  @renewals_app.main_people_page.submit_main_person(person: people[0])
  @renewals_app.declare_convictions_page.submit(choice: :no)
  @renewals_app.contact_name_page.submit
  @renewals_app.contact_telephone_number_page.submit
  @renewals_app.contact_email_page.submit
  @journey_app.address_lookup_page.submit_valid_address
  @renewals_app.check_your_answers_page.submit
  @renewals_app.declaration_page.submit
  @renewals_app.registration_cards_page.submit
  expect(@renewals_app.payment_summary_page.current_url).to include "/payment-summary"
end

When(/^I have my credit card payment rejected$/) do
  @renewals_app.payment_summary_page.submit(choice: :card_payment)
  submit_invalid_card_payment
end

When(/^I cancel my credit card payment$/) do
  @renewals_app.payment_summary_page.submit(choice: :card_payment)
  @journey_app.worldpay_payment_page.cancel_payment
end

Then(/^(?:I can pay with another card|I try my credit card payment again)$/) do
  @renewals_app.payment_summary_page.submit(choice: :card_payment)
  submit_valid_card_payment
end

When(/^I can pay by bank transfer$/) do
  @renewals_app.payment_summary_page.submit(choice: :bank_transfer_payment)
  @renewals_app.bank_transfer_page.submit
end
