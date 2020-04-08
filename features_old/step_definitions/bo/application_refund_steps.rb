# rubocop:disable Metrics/BlockLength
Given(/^I have an application paid by credit card$/) do
  step "an Environment Agency user has signed in to the backend"

  @back_app.registrations_page.new_registration.click
  @back_app.old_start_page.submit
  expect(@journey.location_page.heading).to have_text("Where is your principal place of business?")
  @journey.location_page.submit(choice: :england_old)
  @back_app.business_type_page.submit(org_type: "limitedCompany")
  @back_app.other_businesses_question_page.submit(choice: :no)
  @back_app.construction_waste_question_page.submit(choice: :yes)
  @back_app.registration_type_page.submit(choice: :carrier_broker_dealer)
  @back_app.business_details_page.submit(
    companies_house_number: "00445790",
    company_name: "Credit card test",
    postcode: "BS1 5AH",
    result: "HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH"
  )
  @back_app.contact_details_page.submit(
    first_name: "Bob",
    last_name: "Carolgees",
    phone_number: "0117 4960000"
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

  submit_valid_card_payment

  @reg_number = @back_app.finish_assisted_page.registration_number.text
  @back_app.agency_sign_in_page.load
  @back_app.registrations_page.sign_out.click
end
# rubocop:enable Metrics/BlockLength

When(/^I reverse the application payment$/) do
  @back_app.registrations_page.search(search_input: @reg_number)
  @back_app.registrations_page.search_results[0].payment_status.click
  @payment_amount = @back_app.payment_status_page.payment_history_amount.text
  expect(@back_app.payment_reversals_page).to have_text(@reg_number)
  @back_app.payment_status_page.reversals.click
  @back_app.payment_reversals_page.select_payment.click
  @back_app.new_reversal_page.submit(payment_comment: "Reversal for " + @reg_number)
end

When(/^I select the application to refund$/) do
  @back_app.registrations_page.search(search_input: @reg_number)
  @back_app.registrations_page.search_results[0].payment_status.click
end

When(/^I refund the worldpay payment$/) do
  @back_app.registrations_page.search(search_input: @reg_number)
  @back_app.registrations_page.search_results[0].payment_status.click
  @payment_amount = @back_app.payment_status_page.payment_history_amount.text
  @back_app.payment_status_page.refund.click
  @back_app.refunds_page.refund.click
  @back_app.worldpay_refunds_page.refund.click
end

When(/^the refund will be completed successfully$/) do
  expect(@back_app.refund_complete_page).to have_text("Refund complete")
  @back_app.refund_complete_page.payment_status.click
end

When(/^the balance is paid in full$/) do
  expect(@back_app.payment_status_page).to have_text("Paid in full")
end

Then(/^the application payment will be reversed$/) do
  expect(@back_app.payment_status_page).to have_text("Reversal sucessfully entered")

end

Then(/^the reversal will be shown in the payment history$/) do
  expect(@back_app.payment_status_page).to have_text("Reversal for " + @reg_number)
end

Then(/^the outstanding balance will be the amount previously paid$/) do
  expect(@back_app.payment_status_page.payment_status.text).to eq("Awaiting payment")
  expect(@back_app.payment_status_page.balance.text).to eq(@payment_amount)
end

Then(/^the refund option will not be available$/) do
  @back_app.payment_status_page.reversals.click
  expect(@back_app.payment_reversals_page.select_payment.text).to eq("n/a")
end
