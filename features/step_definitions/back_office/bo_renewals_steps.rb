Given("there is an existing registration") do
  # No action, this just exists to make the feature look nicer
end

Given("NCCC partially renews an existing registration with {string}") do |convictions|
  # Set variables that can be reused across steps.
  @app = :bo
  @tier = :upper
  @organisation_type = :soleTrader if @organisation_type.nil?
  @convictions = convictions
  @business_name = "AD Renewal with #{@convictions}"
  @reg_type = :renewal

  # Search for registration to renew:
  sign_in_to_back_office("agency-refund-payment-user")
  @bo.dashboard_page.view_reg_details(search_term: @reg_number)
  @bo.registration_details_page.renew_link.click

  # Go through renewal journey up to submitting declaration:
  start_internal_renewal
  submit_existing_renewal_details
end

Given("the back office pages show the correct transient renewal details") do
  sign_in_to_back_office("agency-user")
  @bo.dashboard_page.view_transient_reg_details(search_term: @reg_number)

  expect(@bo.registration_details_page.heading).to have_text("Renewal #{@reg_number}")
  expect(@bo.registration_details_page).to have_text "Application in progress"
  expect(@bo.registration_details_page).to have_continue_as_ad_button
  expect(@bo.registration_details_page).to have_text(@business_name)
  expect(@bo.registration_details_page).to have_text("Peek Freans")
  expect(@bo.registration_details_page).to have_text("Application in progress")
  expect(@bo.registration_details_page).to have_no_view_certificate_link

  if @convictions == "no convictions"
    expect(@bo.registration_details_page).to have_text("There are no convictions for this registration")
  end

end

Given("NCCC goes back to the in progress renewal") do
  @bo.registration_details_page.continue_as_ad_button.click
  @bo.ad_privacy_policy_page.submit
end

Then("the renewal is complete") do
  expect(@journey.confirmation_page.heading).to have_text("Renewal complete")
  expect(@journey.confirmation_page).to have_text("Your registration number is still\n#{@reg_number}")
  puts "Renewal #{@reg_number} complete"

  @journey.confirmation_page.finished_button.click
  expect(@bo.registration_details_page.heading).to have_text("Waste carriers registrations")
end

When("I renew the limited company registration") do
  @business_name = "Limited company renewal"
  @bo.dashboard_page.view_reg_details(search_term: @reg_number)
  @bo.registration_details_page.renew_link.click
  @convictions = "no convictions"
  @reg_type = :renewal
  start_internal_renewal
  submit_existing_renewal_details

  order_cards_during_journey(0)
  @journey.payment_summary_page.submit(choice: :card_payment)
  @journey.confirm_payment_method_page.submit(choice: :yes)
  submit_card_payment
end

But("the user has no contact email address") do
  @no_contact_email = true
end

Given("the registration has been partially renewed by the account holder") do
  @journey = JourneyApp.new
  @reg_type = :renewal

  @journey.start_page.load
  @journey.standard_page.accept_cookies

  @journey.start_page.submit(choice: @reg_type)
  @journey.existing_registration_page.submit(reg_no: @reg_number)

  sign_in_to_front_office(Quke::Quke.config.custom["accounts"]["waste_carrier"]["username"])
  agree_to_renew_in_england

  Capybara.reset_session!
end

When("I complete the renewal for the account holder") do
  @business_name = "Assisted digital resumed renewal"
  @app = :bo
  @convictions = "no convictions"
  @reg_type = :renewal
  @bo.dashboard_page.view_transient_reg_details(search_term: @reg_number)
  @bo.registration_details_page.continue_as_ad_button.click
  @bo.ad_privacy_policy_page.submit

  submit_existing_renewal_details
  order_cards_during_journey(0)
  @journey.payment_summary_page.submit(choice: :card_payment)
  @journey.confirm_payment_method_page.submit(choice: :yes)
  submit_card_payment
end

When("I search for the renewal pending payment") do
  @bo.dashboard_page.govuk_banner.home_page.click
  @bo.dashboard_page.view_transient_reg_details(search_term: @reg_number)
end

When("I mark the renewal payment as received") do
  @bo.registration_details_page.process_payment_button.click
  pay_by_cash(105)
  @reg_type = :registration
end

Then("the expiry date should be three years from the previous expiry date") do
  # Adds three years to expiry date and then checks expiry date reported in registration details.
  expected_expiry_date = @expiry_date_year_first.next_year(3)

  visit_registration_details_page(@reg_number)
  actual_expiry_date = expiry_date_from_reg_details

  expect(expected_expiry_date).to eq(actual_expiry_date)
end

Given("I renew the limited company registration declaring a conviction and paying by bank transfer") do
  @business_name = "Renewal with conviction via bank transfer"
  @convictions = "convictions"
  @bo.dashboard_page.view_reg_details(search_term: @reg_number)
  @bo.registration_details_page.renew_link.click

  start_internal_renewal
  submit_existing_renewal_details

  order_cards_during_journey(0)
  @journey.payment_summary_page.submit(choice: :bank_transfer_payment)
  @journey.payment_bank_transfer_page.submit
  @bo.dashboard_page.govuk_banner.home_page.click
end

When("I approve the conviction check for the renewal") do
  @bo.dashboard_page.govuk_banner.conviction_checks_link.click
  visit((Quke::Quke.config.custom["urls"]["back_office"]) + "/transient-registrations/#{@reg_number}/convictions")

  @bo.convictions_bo_details_page.approve_button.click
  @bo.convictions_decision_page.submit(conviction_reason: "ok")
end

Then("I will receive a registration renewal reminder email") do
  expected_text = ["Renew waste carrier registration #{@reg_number}"]
  expect(message_exists?(expected_text)).to be true
end
