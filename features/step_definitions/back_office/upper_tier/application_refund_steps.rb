Given(/^I have an application paid by credit card$/) do
  step "an Environment Agency user has signed in"

  @app.registrations_page.new_registration.click
  @app.start_page.submit
  @app.business_type_page.submit(org_type: "limitedCompany")
  @app.other_businesses_question_page.submit(choice: :no)
  @app.construction_waste_question_page.submit(choice: :yes)
  @app.registration_type_page.submit(choice: :carrier_broker_dealer)
  @app.business_details_page.submit(
    companies_house_number: "00233462",
    company_name: "Credit card test",
    postcode: "BS1 5AH",
    result: "ENVIRONMENT AGENCY, HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH"
  )
  @app.contact_details_page.submit(
    first_name: "Bob",
    last_name: "Carolgees",
    phone_number: "012345678"
  )
  @app.postal_address_page.submit

  people = @app.key_people_page.key_people

  @app.key_people_page.add_key_person(person: people[0])
  @app.key_people_page.add_key_person(person: people[1])
  @app.key_people_page.submit_key_person(person: people[2])

  @app.relevant_convictions_page.submit(choice: :no)
  @app.declaration_page.submit
  @app.order_page.submit(
    copy_card_number: "1",
    choice: :maestro
  )
  @app.worldpay_card_choice_page.maestro.click

  # finds today's date and adds another year to expiry date
  time = Time.new

  @year = time.year + 1

  @app.worldpay_card_details_page.submit(
    card_number: "6759649826438453",
    security_code: "555",
    cardholder_name: "3d.authorised",
    expiry_month: "12",
    expiry_year: @year
  )
  @refund_registration = @app.finish_assisted_page.registration_number.text
  @app.login_page.load
  @app.registrations_page.sign_out.click
end

When(/^I refund the application payment$/) do
  @app.registrations_page.search(search_input: @refund_registration)
  @app.registrations_page.first_search_result_payment_status_action.click
  @payment_amount = @app.payment_status_page.payment_history_amount.text
  expect(@app.payment_reversals_page).to have_text(@refund_registration)
  @app.payment_status_page.reversals.click
  @app.payment_reversals_page.select_payment.click
  @app.new_reversal_page.submit(payment_comment: "Refund for " + @refund_registration)
end

When(/^select the application to refund$/) do
  @app.registrations_page.search(search_input: @refund_registration)
  @app.registrations_page.first_search_result_payment_status_action.click
  @payment_amount = @app.payment_status_page.payment_history_amount.text
  expect(@app.payment_reversals_page).to have_text(@refund_registration)
  @app.payment_status_page.reversals.click
end

Then(/^the application payment will be refunded$/) do
  expect(@app.payment_status_page).to have_text("Reversal sucessfully entered")

end

Then(/^the refund will be shown in the payment history$/) do
  expect(@app.payment_status_page).to have_text("Refund for " + @refund_registration)
end

Then(/^the outstanding balance will be the amount previously paid$/) do
  expect(@app.payment_status_page.payment_status.text).to eq("Awaiting payment")
  expect(@app.payment_status_page.balance.text).to eq(@payment_amount)
end

Then(/^the refund option will not be available$/) do
  expect(@app.payment_reversals_page.select_payment.text).to eq("n/a")
end
