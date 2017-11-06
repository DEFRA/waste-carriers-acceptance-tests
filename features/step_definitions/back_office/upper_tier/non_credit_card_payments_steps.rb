Given(/^I have an application that is pending payment$/) do
  @app = FrontOfficeApp.new
  @app.start_page.load
  @app.start_page.submit
  @app.business_type_page.submit(org_type: "soleTrader")
  @app.other_businesses_question_page.submit(choice: :yes)
  @app.service_provided_question_page.submit(choice: :not_main_service)
  @app.construction_waste_question_page.submit(choice: :yes)
  @app.registration_type_page.submit(choice: :carrier_dealer)
  @app.business_details_page.submit(
    company_name: "Offline payment",
    postcode: "BS1 5AH",
    result: "ENVIRONMENT AGENCY, HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH"
  )
  @email = @app.generate_email
  @app.contact_details_page.submit(
    first_name: "Bob",
    last_name: "Debuilder",
    phone_number: "012345678",
    email: @email
  )
  puts @email
  @app.postal_address_page.submit

  people = @app.key_people_page.key_people
  @app.key_people_page.submit_key_person(person: people[0])

  @app.relevant_convictions_page.submit(choice: :no)
  @app.declaration_page.submit
  @app.sign_up_page.submit(
    registration_password: "Secret123",
    confirm_password: "Secret123",
    confirm_email: @email
  )
  @app.order_page.submit(
    copy_card_number: "2",
    choice: :bank_transfer_payment
  )
  @app.offline_payment_page.submit
  # Stores registration number for later use
  @registration_number = @app.registration_confirmed_page.registration_number.text

end

When(/^I enter a cash payment for the full amount owed$/) do
  @app.registrations_page.search(search_input: @registration_number)
  @app.registrations_page.search_results[0].payment_status.click
  @app.payment_status_page.enter_payment.click
  # Finds the amount needed to be paid and strips off the pound sign
  @amount_due = @app.payments_page.amount_due.text[1..-1]
  @app.payments_page.submit(
    payment_amount: @amount_due,
    payment_day: "1",
    payment_month: "1",
    payment_year: "2017",
    payment_ref: "Test",
    payment_type: "Cash",
    payment_comment: "exact cash payment"
  )
  expect(@app.payment_status_page.payment_status.text).to eq("Paid in full")
  expect(@app.payment_status_page.balance.text).to eq("0.00")
  @app.payment_status_page.back_link.click
end

When(/^I enter a cheque payment overpaying for the amount owed$/) do
  @app.registrations_page.search(search_input: @registration_number)
  @app.registrations_page.search_results[0].payment_status.click
  @app.payment_status_page.enter_payment.click
  # Finds the amount needed to be paid and strips off the pound sign
  @amount_due = @app.payments_page.amount_due.text[1..-1]
  @small_overpayment = @amount_due.to_i + 1
  @app.payments_page.submit(
    payment_amount: @small_overpayment,
    payment_day: "1",
    payment_month: "1",
    payment_year: "2017",
    payment_ref: "Test",
    payment_type: "Cheque",
    payment_comment: "cheque overpayment payment"
  )
  @app.payment_status_page.back_link.click
end

When(/^I enter a postal order payment underpaying for the amount owed$/) do
  @app.registrations_page.search(search_input: @registration_number)
  @app.registrations_page.search_results[0].payment_status.click
  @app.payment_status_page.enter_payment.click
  # Finds the amount needed to be paid and strips off the pound sign
  @amount_due = @app.payments_page.amount_due.text[1..-1]
  @small_underpayment = @amount_due.to_i - 1
  @app.payments_page.submit(
    payment_amount: @small_underpayment,
    payment_day: "1",
    payment_month: "1",
    payment_year: "2017",
    payment_ref: "Test",
    payment_type: "Postal order",
    payment_comment: "postal order underpayment payment"
  )
  @app.payment_status_page.back_link.click
end

When(/^I enter a bank transfer payment for the full amount owed$/) do
  @app.registrations_page.search(search_input: @registration_number)
  @app.registrations_page.search_results[0].payment_status.click
  @app.payment_status_page.enter_payment.click
  # Finds the amount needed to be paid and strips off the pound sign
  @amount_due = @app.payments_page.amount_due.text[1..-1]
  @app.payments_page.submit(
    payment_amount: @amount_due,
    payment_day: "1",
    payment_month: "1",
    payment_year: "2017",
    payment_ref: "Test",
    payment_type: "Bank transfer payment",
    payment_comment: "exact bank transfer payment"
  )
  @app.payment_status_page.back_link.click
end

Then(/^the registration will be marked as awaiting payment$/) do
  @app.registrations_page.search(search_input: @registration_number)
  expect(@app.registrations_page.search_results[0].status.text).to eq("Awaiting payment")
end

Then(/^the payment status will be marked as overpaid$/) do
  @app.registrations_page.search(search_input: @registration_number)
  @app.registrations_page.search_results[0].payment_status.click
  expect(@app.payment_status_page.payment_status.text).to eq("Overpaid by")
  expect(@app.payment_status_page.balance.text).to eq("1.00")
end

Then(/^the payment status will be marked as underpaid$/) do
  @app.registrations_page.search(search_input: @registration_number)
  @app.registrations_page.search_results[0].payment_status.click
  expect(@app.payment_status_page.payment_status.text).to eq("Awaiting payment")
  expect(@app.payment_status_page.balance.text).to eq("1.00")
end

Then(/^the registration will be marked as complete$/) do
  @app.registrations_page.search(search_input: @registration_number)
  expect(@app.registrations_page.search_results[0].status.text).to eq("Registered")

end
