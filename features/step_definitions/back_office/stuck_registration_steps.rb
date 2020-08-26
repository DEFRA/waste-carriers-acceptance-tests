When("I register and get stuck at the payment stage") do
  step("I want to register as an upper tier carrier")
  step("I start a new registration journey in 'England' as a 'soleTrader'")

  # Generate random business name containing the word "Stuck", to
  # simulate a stuck payment in mock mode, and make it searchable later
  @business_name = "Stuck registration " + rand(1..999_999).to_s
  step("I complete my registration for my business '#{@business_name}'")
  @journey.payment_summary_page.submit(choice: :card_payment)
end

When("I start renewing my last registration from the email") do
  @journey = JourneyApp.new
  @reg_type = :renewal
  visit(@renew_from_email_link)
  expect(page).to have_text("You are about to renew registration " + @reg_number)
end

When("I complete the renewal steps and get stuck at the payment stage") do
  @business_name ||= "Stuck renewal " + rand(1..999_999).to_s
  agree_to_renew_in_england
  submit_existing_renewal_details

  order_cards_during_journey(0)
  @journey.payment_summary_page.submit(choice: :card_payment)
  # If mocking is turned on and @business_name contains "stuck", user will see a "stuck" page.
  # If mocking is off, user will see a Worldpay payment screen.
end

When("I revert the current registration to payment summary") do
  # Search for registration by name as it doesn't have a CBD number yet:
  @bo.dashboard_page.view_new_reg_details(search_term: @business_name)
  @bo.registration_details_page.revert_to_payment_summary_link.click
end

When("I revert the current renewal to payment summary") do
  visit_renewal_details_page(@reg_number)
  @bo.registration_details_page.revert_to_payment_summary_link.click
end

Then("I can submit the stuck user's application by bank transfer") do
  # User is already logged in and at the payment summary screen here.
  # Because mocking works based on the company name, which is already defined by this point, we can't easily
  # test resubmitting a WorldPay payment here. So this test covers the bank transfer option instead.

  step("I pay by bank transfer")

  @reg_number = @journey.confirmation_page.registration_number.text
  puts @reg_number + " submitted with outstanding payment"
  if @reg_type == :renewal
    expect(@journey.confirmation_page).to have_content("Application received")
  else
    expect(@journey.confirmation_page).to have_content("You must now pay by bank transfer")
  end
end
