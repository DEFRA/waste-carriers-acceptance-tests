When(/^the registration's balance is (\d+)$/) do |balance|
  sign_in_to_back_office("agency_user_with_payment_refund")

  # Firstly, check the balance for that registration:
  check_registration_details(@registration_number)
  check_balance(balance)

  # Once confirmed, set the balance variable to that value for future steps
  @reg_balance = balance

end

When(/^the transient renewal's balance is (\d+)$/) do |balance|
  # This step assumes that any back office user is already logged in
  # and the payment status is viewable for that renewal (it's been submitted)

  visit((Quke::Quke.config.custom["urls"]["back_office_renewals"]) + "/bo")
  @bo.dashboard_page.view_transient_reg_details(search_term: @registration_number)
  check_balance(balance)

  # Once checked, set the balance variable to that value for future steps
  @reg_balance = balance
end

When(/^NCCC makes a payment of (\d+) by "([^"]*)"$/) do |amount, method|
  sign_in_as_appropriate_finance_user(method)
  go_to_payment(@registration_number)
  enter_payment(amount, method)
  check_payment_confirmation_message(amount)
end

When(/^NCCC pays the remaining balance by "([^"]*)"$/) do |method|
  sign_in_as_appropriate_finance_user(method)
  go_to_payment(@registration_number)
  enter_payment(@reg_balance, method)
  check_payment_confirmation_message(@reg_balance)
end

Given(/^registration "([^"]*)" has a renewal paid by bank transfer$/) do |reg|
  @registration_number = reg
  @is_transient_renewal = true

  @bo.registrations_page.search(search_input: reg.to_sym)
  @expiry_date = @bo.registrations_page.search_results[0].expiry_date.text
  # Turns the text expiry date into a date
  @expiry_date_year_first = Date.parse(@expiry_date)

  @bo.sign_in_page.load
  @bo.sign_in_page.submit(
    email: Quke::Quke.config.custom["accounts"]["agency_user_with_payment_refund"]["username"],
    password: ENV["WCRS_DEFAULT_PASSWORD"]
  )
  @bo.dashboard_page.view_reg_details(search_term: @registration_number)
  @bo.registration_details_page.renew_link.click

  start_internal_renewal
  @journey.confirm_business_type_page.submit
  @journey.tier_check_page.submit(choice: :skip_check)
  @journey.carrier_type_page.submit
  @bo.renewal_information_page.submit
  submit_business_details
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
  @bo.registration_cards_page.submit
  @bo.payment_summary_page.submit(choice: :bank_transfer_payment)
  @bo.bank_transfer_page.submit
end
