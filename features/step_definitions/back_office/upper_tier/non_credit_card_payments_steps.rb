Given(/^I have an application that is pending payment$/) do
  @back_app = BackOfficeApp.new
  @back_app.start_page.load
  @back_app.start_page.submit
  @back_app.business_type_page.submit(org_type: "soleTrader")
  @back_app.other_businesses_question_page.submit(choice: :yes)
  @back_app.service_provided_question_page.submit(choice: :not_main_service)
  @back_app.construction_waste_question_page.submit(choice: :yes)
  @back_app.registration_type_page.submit(choice: :carrier_dealer)
  @back_app.business_details_page.submit(
    company_name: "Offline payment",
    postcode: "S60 1BY",
    result: "ENVIRONMENT AGENCY, BOW BRIDGE CLOSE, ROTHERHAM, S60 1BY"
  )
  @email = @back_app.generate_email
  @back_app.contact_details_page.submit(
    first_name: "Bob",
    last_name: "Debuilder",
    phone_number: "012345678",
    email: @email
  )
  @back_app.postal_address_page.submit

  people = @back_app.key_people_page.key_people
  @back_app.key_people_page.submit_key_person(person: people[0])

  @back_app.relevant_convictions_page.submit(choice: :no)
  @back_app.declaration_page.submit
  @back_app.sign_up_page.submit(
    registration_password: "Secret123",
    confirm_password: "Secret123",
    confirm_email: @email
  )
  @back_app.order_page.submit(
    copy_card_number: "2",
    choice: :bank_transfer_payment
  )
  @back_app.offline_payment_page.submit
  # Stores registration number for later use
  @registration_number = @back_app.registration_confirmed_page.registration_number.text

end

When(/^I enter a cash payment for the full amount owed$/) do
  @back_app.registrations_page.search(search_input: @registration_number)
  @back_app.registrations_page.search_results[0].payment_status.click
  @back_app.payment_status_page.enter_payment.click
  # Finds the amount needed to be paid and strips off the pound sign
  @amount_due = @back_app.payments_page.amount_due.text[1..-1]
  @back_app.payments_page.submit(
    payment_amount: @amount_due,
    payment_day: "1",
    payment_month: "1",
    payment_year: "2017",
    payment_ref: "Test",
    payment_type: "Cash",
    payment_comment: "exact cash payment"
  )
  expect(@back_app.payment_status_page.payment_status.text).to eq("Paid in full")
  expect(@back_app.payment_status_page.balance.text).to eq("0.00")
  @back_app.payment_status_page.back_link.click
end

When(/^I enter a cheque payment overpaying for the amount owed$/) do
  @back_app.registrations_page.search(search_input: @registration_number)
  @back_app.registrations_page.search_results[0].payment_status.click
  @back_app.payment_status_page.enter_payment.click
  # Finds the amount needed to be paid and strips off the pound sign
  @amount_due = @back_app.payments_page.amount_due.text[1..-1]
  @small_overpayment = @amount_due.to_i + 1
  @back_app.payments_page.submit(
    payment_amount: @small_overpayment,
    payment_day: "1",
    payment_month: "1",
    payment_year: "2017",
    payment_ref: "Test",
    payment_type: "Cheque",
    payment_comment: "cheque overpayment payment"
  )
  @back_app.payment_status_page.back_link.click
end

When(/^I enter a postal order payment underpaying for the amount owed$/) do
  @back_app.registrations_page.search(search_input: @registration_number)
  @back_app.registrations_page.search_results[0].payment_status.click
  @back_app.payment_status_page.enter_payment.click
  # Finds the amount needed to be paid and strips off the pound sign
  @amount_due = @back_app.payments_page.amount_due.text[1..-1]
  @small_underpayment = @amount_due.to_i - 1
  @back_app.payments_page.submit(
    payment_amount: @small_underpayment,
    payment_day: "1",
    payment_month: "1",
    payment_year: "2017",
    payment_ref: "Test",
    payment_type: "Postal order",
    payment_comment: "postal order underpayment payment"
  )
  @back_app.payment_status_page.back_link.click
end

When(/^I enter a bank transfer payment for the full amount owed$/) do
  @back_app.registrations_page.search(search_input: @registration_number)
  @back_app.registrations_page.search_results[0].payment_status.click
  @back_app.payment_status_page.enter_payment.click
  # Finds the amount needed to be paid and strips off the pound sign
  @amount_due = @back_app.payments_page.amount_due.text[1..-1]
  @back_app.payments_page.submit(
    payment_amount: @amount_due,
    payment_day: "1",
    payment_month: "1",
    payment_year: "2017",
    payment_ref: "Test",
    payment_type: "Bank transfer payment",
    payment_comment: "exact bank transfer payment"
  )
  @back_app.payment_status_page.back_link.click
end

Then(/^the payment status will be marked as overpaid$/) do
  @back_app.registrations_page.search(search_input: @registration_number)
  @back_app.registrations_page.search_results[0].payment_status.click
  expect(@back_app.payment_status_page.payment_status.text).to eq("Overpaid by")
  expect(@back_app.payment_status_page.balance.text).to eq("1.00")
end

Then(/^the payment status will be marked as underpaid$/) do
  @back_app.registrations_page.search(search_input: @registration_number)
  @back_app.registrations_page.search_results[0].payment_status.click
  expect(@back_app.payment_status_page.payment_status.text).to eq("Awaiting payment")
  expect(@back_app.payment_status_page.balance.text).to eq("1.00")
end

Then(/^the registration will be marked as "([^"]*)"$/) do |status|
  @back_app.registrations_page.search(search_input: @registration_number)
  expect(@back_app.registrations_page.search_results[0].status.text).to eq(status)

end
