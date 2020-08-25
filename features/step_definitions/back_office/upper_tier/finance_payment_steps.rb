When(/^the registration's balance is (-?\d+)$/) do |balance|
  sign_in_to_back_office("agency-refund-payment-user")

  # Firstly, check the balance for that registration:
  visit_finance_details_page(@reg_number)
  check_balance(balance)

  # Once confirmed, set the balance variable to that value for future steps
  @reg_balance = balance

  @reg_type = :registration if balance.zero? && @convictions == "no convictions"
end

When("the renewal has been completed") do
  @reg_type = :registration
end

When(/^the applicant chooses to pay for the registration by bank transfer ordering (\d+) copy (?:card|cards)$/) do |copy_card_number|
  @old.old_order_page.submit(
    copy_card_number: copy_card_number,
    choice: :bank_transfer_payment
  )
  @old.offline_payment_page.submit

  # Show "Registration pending" page
  expect(@old.finish_assisted_page).to have_text("Registration pending")
  expect(@old.finish_assisted_page.registration_number).to have_text("CBDU")

  @reg_number = @old.finish_assisted_page.registration_number.text
  puts "Registration " + @reg_number + " submitted by bank transfer with " + copy_card_number.to_s + " card(s)"
  @reg_balance = 154 + copy_card_number * 5

end

When(/^I pay for my application over the phone by maestro ordering (\d+) copy (?:card|cards)$/) do |copy_card_number|
  @old.old_order_page.submit(
    copy_card_number: copy_card_number,
    choice: :card_payment
  )
  submit_valid_card_payment
end

When(/^the transient renewal's balance is (-?\d+)$/) do |balance|
  # This step assumes that any back office user is already logged in
  # and the payment status is viewable for that renewal (it's been submitted)

  visit_finance_details_page(@reg_number)
  check_balance(balance)

  # Once checked, set the balance variable to that value for future steps
  @reg_balance = balance
end

When(/^NCCC makes a payment of (\d+) by "([^"]*)"$/) do |amount, method|
  sign_in_as_appropriate_finance_user(method)
  enter_payment(amount, method)
  check_payment_confirmation_message(amount)
  @reg_balance -= amount
end

When(/^NCCC pays the remaining balance by "([^"]*)"$/) do |method|
  sign_in_as_appropriate_finance_user(method)
  enter_payment(@reg_balance, method)
  check_payment_confirmation_message(@reg_balance)
  @reg_balance = 0
end

Given(/^the registration has an unsubmitted renewal$/) do
  @reg_type = :renewal
  @business_name = "Renewal via bank transfer"
  @convictions = "no convictions"

  @bo.sign_in_page.load
  @bo.sign_in_page.submit(
    email: Quke::Quke.config.custom["accounts"]["agency-refund-payment-user"]["username"],
    password: ENV["WCRS_DEFAULT_PASSWORD"]
  )
  @bo.dashboard_page.view_reg_details(search_term: @reg_number)
  @expiry_date_year_first = expiry_date_from_reg_details

  @bo.registration_details_page.renew_link.click

  start_internal_renewal
  submit_existing_renewal_details

  order_cards_during_journey(0)
  @journey.payment_summary_page.submit(choice: :bank_transfer_payment)
end

Then(/^I cannot access payments until the bank transfer option is selected$/) do
  # Check that there is no payment details link just before submitting a renewal (see RUBY-908):
  find_link("Registrations search").click
  @bo.dashboard_page.view_transient_reg_details(search_term: @reg_number)
  expect(@bo.registration_details_page).to have_no_payment_details_link

  # Then submit the renewal:
  @bo.registration_details_page.continue_as_ad_button.click
  @bo.ad_privacy_policy_page.submit
  @journey.payment_bank_transfer_page.submit
end

When(/^the applicant chooses to pay for the renewal by bank transfer ordering (\d+) copy (?:card|cards)$/) do |copy_card_number|
  order_cards_during_journey(copy_card_number)
  @journey.payment_summary_page.submit(choice: :bank_transfer_payment)
  @journey.payment_bank_transfer_page.submit
end

And(/^the applicant pays by bank card$/) do
  # On the new app, the payment choice is on a different screen from order copy cards
  if @app == "old"
    old_order_cards_during_journey(3)
  else
    order_cards_during_journey(1)
    @journey.payment_summary_page.submit(choice: :card_payment)
  end
  submit_valid_card_payment

  @reg_balance = 0
end
