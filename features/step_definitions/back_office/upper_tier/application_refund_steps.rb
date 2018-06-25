Given(/^I have an application paid by credit card$/) do
  step "an Environment Agency user has signed in"

  @back_app.registrations_page.new_registration.click
  @back_app.start_page.submit
  @back_app.business_type_page.submit(org_type: "limitedCompany")
  @back_app.other_businesses_question_page.submit(choice: :no)
  @back_app.construction_waste_question_page.submit(choice: :yes)
  @back_app.registration_type_page.submit(choice: :carrier_broker_dealer)
  @back_app.business_details_page.submit(
    companies_house_number: "00445790",
    company_name: "Credit card test",
    postcode: "BS1 5AH",
    result: "NATURAL ENGLAND, HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH"
  )
  @back_app.contact_details_page.submit(
    first_name: "Bob",
    last_name: "Carolgees",
    phone_number: "012345678"
  )
  @back_app.postal_address_page.submit

  people = @back_app.key_people_page.key_people

  @back_app.key_people_page.add_key_person(person: people[0])
  @back_app.key_people_page.add_key_person(person: people[1])
  @back_app.key_people_page.submit_key_person(person: people[2])

  @back_app.relevant_convictions_page.submit(choice: :no)
  @back_app.check_details_page.submit
  @back_app.order_page.submit(
    copy_card_number: "1",
    choice: :card_payment
  )
  click(@back_app.worldpay_card_choice_page.maestro)

  # finds today's date and adds another year to expiry date
  time = Time.new

  @year = time.year + 1

  @back_app.worldpay_card_details_page.submit(
    card_number: "6759649826438453",
    security_code: "555",
    cardholder_name: "3d.authorised",
    expiry_month: "12",
    expiry_year: @year
  )
  @registration_number = @back_app.finish_assisted_page.registration_number.text
  @back_app.agency_sign_in_page.load
  @back_app.registrations_page.sign_out.click
end

When(/^I refund the application payment$/) do
  @back_app.registrations_page.search(search_input: @registration_number)
  @back_app.registrations_page.search_results[0].payment_status.click
  @payment_amount = @back_app.payment_status_page.payment_history_amount.text
  expect(@back_app.payment_reversals_page).to have_text(@registration_number)
  @back_app.payment_status_page.reversals.click
  @back_app.payment_reversals_page.select_payment.click
  @back_app.new_reversal_page.submit(payment_comment: "Refund for " + @registration_number)
end

When(/^I select the application to refund$/) do
  @back_app.registrations_page.search(search_input: @registration_number)
  @back_app.registrations_page.search_results[0].payment_status.click
  @payment_amount = @back_app.payment_status_page.payment_history_amount.text
  expect(@back_app.payment_reversals_page).to have_text(@registration_number)
  @back_app.payment_status_page.reversals.click
end

Then(/^the application payment will be refunded$/) do
  expect(@back_app.payment_status_page).to have_text("Reversal sucessfully entered")

end

Then(/^the refund will be shown in the payment history$/) do
  expect(@back_app.payment_status_page).to have_text("Refund for " + @registration_number)
end

Then(/^the outstanding balance will be the amount previously paid$/) do
  expect(@back_app.payment_status_page.payment_status.text).to eq("Awaiting payment")
  expect(@back_app.payment_status_page.balance.text).to eq(@payment_amount)
end

Then(/^the refund option will not be available$/) do
  expect(@back_app.payment_reversals_page.select_payment.text).to eq("n/a")
end
