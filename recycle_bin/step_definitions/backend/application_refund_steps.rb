# rubocop:disable Metrics/BlockLength
Given(/^I have an application paid by credit card$/) do
  step "an Environment Agency user has signed in to the backend"

  @old.backend_registrations_page.new_registration.click
  @old.old_start_page.submit
  expect(@journey.location_page.heading).to have_text("Where is your principal place of business?")
  @journey.location_page.submit(choice: :england)
  @old.old_business_type_page.submit(org_type: "limitedCompany")
  @old.other_businesses_question_page.submit(choice: :no)
  @old.construction_waste_question_page.submit(choice: :yes)
  @old.registration_type_page.submit(choice: :carrier_broker_dealer)
  @old.business_details_page.submit(
    companies_house_number: "00445790",
    company_name: "Credit card test",
    postcode: "BS1 5AH",
    result: "HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH"
  )
  @old.contact_details_page.submit(
    first_name: "Bob",
    last_name: "Carolgees",
    phone_number: "0117 4960000"
  )
  @old.postal_address_page.submit

  people = @old.key_people_page.key_people

  @old.key_people_page.add_key_person(person: people[0])
  @old.key_people_page.add_key_person(person: people[1])
  @old.key_people_page.submit_key_person(person: people[2])

  @old.relevant_convictions_page.submit(choice: :no)
  @old.check_details_page.submit
  @old.old_order_page.submit(
    copy_card_number: "1",
    choice: :card_payment
  )

  submit_valid_card_payment

  @reg_number = @old.finish_assisted_page.registration_number.text
  @old.agency_sign_in_page.load
  @old.backend_registrations_page.sign_out.click
end
# rubocop:enable Metrics/BlockLength

When(/^I reverse the application payment$/) do
  @old.backend_registrations_page.search(search_input: @reg_number)
  @old.backend_registrations_page.search_results[0].payment_status.click
  @payment_amount = @old.payment_status_page.payment_history_amount.text
  expect(@old.payment_reversals_page).to have_text(@reg_number)
  @old.payment_status_page.reversals.click
  @old.payment_reversals_page.select_payment.click
  @old.new_reversal_page.submit(payment_comment: "Reversal for " + @reg_number)
end

When(/^I select the application to refund$/) do
  @old.backend_registrations_page.search(search_input: @reg_number)
  @old.backend_registrations_page.search_results[0].payment_status.click
end

When(/^I refund the worldpay payment$/) do
  @old.backend_registrations_page.search(search_input: @reg_number)
  @old.backend_registrations_page.search_results[0].payment_status.click
  @payment_amount = @old.payment_status_page.payment_history_amount.text
  @old.payment_status_page.refund.click
  @old.refunds_page.refund.click
  @old.worldpay_refunds_page.refund.click
end

When(/^the refund will be completed successfully$/) do
  expect(@old.refund_complete_page).to have_text("Refund complete")
  @old.refund_complete_page.payment_status.click
end

When(/^the balance is paid in full$/) do
  expect(@old.payment_status_page).to have_text("Paid in full")
end

Then(/^the application payment will be reversed$/) do
  expect(@old.payment_status_page).to have_text("Reversal sucessfully entered")

end

Then(/^the reversal will be shown in the payment history$/) do
  expect(@old.payment_status_page).to have_text("Reversal for " + @reg_number)
end

Then(/^the outstanding balance will be the amount previously paid$/) do
  expect(@old.payment_status_page.payment_status.text).to eq("Awaiting payment")
  expect(@old.payment_status_page.balance.text).to eq(@payment_amount)
end

Then(/^the refund option will not be available$/) do
  @old.payment_status_page.reversals.click
  expect(@old.payment_reversals_page.select_payment.text).to eq("n/a")
end
