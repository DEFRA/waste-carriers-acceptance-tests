Given("I complete my renewal up to the payment page") do
  # Adding "reject" in the company name ensures payment will be rejected by the Worldpay mock here, if activated:
  @business_name ||= "Renewal with rejected payment"
  @journey.standard_page.accept_cookies

  agree_to_renew_in_england
  @journey.confirm_business_type_page.submit
  @journey.carrier_type_page.submit(choice: :carrier_dealer)
  @journey.renewal_information_page.submit
  @journey.check_registered_company_name_page.submit(choice: :confirm)
  submit_company_people
  @journey.company_name_page.submit(company_name: @business_name)
  complete_address_with_random_method
  submit_convictions("no convictions")
  submit_contact_details_for_renewal
  check_your_answers
  order_cards_during_journey(0)
  expect(@journey.payment_summary_page.current_url).to include "/payment-summary"
end

When("I have my credit card payment rejected") do
  @journey.payment_summary_page.submit(choice: :card_payment)
  submit_invalid_card_payment unless mocking_enabled?
  @journey.cards_payment_page.wait_until_submit_button_visible
  expect(@journey.payment_summary_page).to have_text("Your payment has been refused.")
end

When("I cancel my credit card payment") do
  @journey.payment_summary_page.submit(choice: :card_payment)
  @journey.worldpay_payment_page.cancel_payment unless mocking_enabled?
  expect(@journey.payment_summary_page.error_summary).to have_text("Your attempt to pay has been cancelled.")
end

When("I pay by card") do
  @journey.payment_summary_page.submit(choice: :card_payment)
  submit_valid_card_payment
end

When("I pay by bank transfer") do
  @journey.payment_summary_page.submit(choice: :bank_transfer_payment)
  @journey.payment_bank_transfer_page.submit
end
