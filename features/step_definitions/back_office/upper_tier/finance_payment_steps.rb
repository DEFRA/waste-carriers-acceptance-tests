When(/^the registration's balance is (-?\d+)$/) do |balance|
  sign_in_to_back_office("agency-refund-payment-user")

  # Firstly, check the balance for that registration:
  visit_registration_finance_details_page(@reg_number)
  check_balance(balance)

  # Once confirmed, set the balance variable to that value for future steps
  @reg_balance = balance

  @resource_object = :registration if balance.zero? && @convictions == "no convictions"
end

When(/^the applicant chooses to pay for the registration by bank transfer ordering (\d+) copy (?:card|cards)$/) do |copy_card_number|
  @back_app.order_page.submit(
    copy_card_number: copy_card_number,
    choice: :bank_transfer_payment
  )
  @back_app.offline_payment_page.submit

  # Show "Registration pending" page
  expect(@back_app.finish_assisted_page).to have_text("Registration pending")
  expect(@back_app.finish_assisted_page.registration_number).to have_text("CBDU")

  @reg_number = @back_app.finish_assisted_page.registration_number.text
  puts "Registration " + @reg_number + " submitted by bank transfer with " + copy_card_number.to_s + " card(s)"
  @reg_balance = 154 + copy_card_number * 5

end

When(/^I pay for my application over the phone by maestro ordering (\d+) copy (?:card|cards)$/) do |copy_card_number|
  @back_app.order_page.submit(
    copy_card_number: copy_card_number,
    choice: :card_payment
  )
  submit_valid_card_payment
end

When(/^the transient renewal's balance is (-?\d+)$/) do |balance|
  # This step assumes that any back office user is already logged in
  # and the payment status is viewable for that renewal (it's been submitted)

  visit_renewal_finance_details_page(@reg_number)
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

Given(/^registration "([^"]*)" has an unsubmitted renewal$/) do |reg|
  @reg_number = reg
  @resource_object = :renewal
  @business_name = "Renewal via bank transfer"

  @back_app.registrations_page.search(search_input: reg.to_sym)
  @expiry_date = @back_app.registrations_page.search_results[0].expiry_date.text
  # Turns the text expiry date into a date
  @expiry_date_year_first = Date.parse(@expiry_date)

  @bo.sign_in_page.load
  @bo.sign_in_page.submit(
    email: Quke::Quke.config.custom["accounts"]["agency-refund-payment-user"]["username"],
    password: ENV["WCRS_DEFAULT_PASSWORD"]
  )
  @bo.dashboard_page.view_reg_details(search_term: @reg_number)
  @bo.registration_details_page.renew_link.click

  start_internal_renewal
  @journey.confirm_business_type_page.submit
  @journey.tier_check_page.submit(choice: :skip_check)
  @journey.carrier_type_page.submit
  @bo.renewal_information_page.submit
  submit_business_details(@business_name)
  submit_company_people
  submit_convictions("no convictions")
  @journey.contact_name_page.submit
  @journey.contact_phone_page.submit
  @journey.contact_email_page.submit(
    email: "bo-user@example.com",
    confirm_email: "bo-user@example.com"
  )
  @journey.address_lookup_page.submit_invalid_address
  @journey.address_manual_page.submit(
    house_number: "1",
    address_line_one: "Test lane",
    address_line_two: "Testville",
    city: "Teston"
  )
  check_your_answers
  @journey.registration_cards_page.submit
  @bo.payment_summary_page.submit(choice: :bank_transfer_payment)

end

Then(/^I cannot access payments until the bank transfer option is selected$/) do
  # Check that there is no payment details link just before submitting a renewal (see RUBY-908):
  find_link("Registrations search").click
  @bo.dashboard_page.view_transient_reg_details(search_term: @reg_number)
  expect(@bo.registration_details_page).to have_no_payment_details_link

  # Then submit the renewal:
  @bo.registration_details_page.continue_as_ad_button.click
  @bo.ad_privacy_policy_page.submit
  @bo.bank_transfer_page.submit
end

When(/^the applicant chooses to pay for the renewal by bank transfer ordering (\d+) copy (?:card|cards)$/) do |copy_card_number|
  order_cards_during_journey(copy_card_number)
  @bo.payment_summary_page.submit(choice: :bank_transfer_payment)
  @bo.bank_transfer_page.submit
end

And(/^the applicant pays by bank card$/) do
  # On the new app, the payment choice is on a different screen from order copy cards
  if @app == "old"
    old_order_cards_during_journey(3)
  else
    order_cards_during_journey(1)
    @bo.payment_summary_page.submit(choice: :card_payment)
  end
  submit_valid_card_payment

  @reg_balance = 0
end
