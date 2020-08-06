Given(/I choose to edit my registration "([^"]*)"$/) do |reg_no|
  Capybara.reset_session!
  @old = OldApp.new
  @journey = JourneyApp.new
  @old.frontend_sign_in_page.load
  @old.frontend_sign_in_page.submit(
    email: Quke::Quke.config.custom["accounts"]["waste_carrier"]["username"],
    password: ENV["WCRS_DEFAULT_PASSWORD"]
  )
  @reg_number = reg_no

  @fo.waste_carrier_registrations_page.find_registration(@reg_number)
  @fo.waste_carrier_registrations_page.edit(@reg_number)
end

When(/^I change my registration type to "([^"]*)"$/) do |registration_type|
  @old.check_details_page.edit_registration_type.click
  @old.registration_type_page.submit(choice: registration_type.to_sym)
  @old.check_details_page.submit
end

When(/^I add another partner to my registration$/) do
  @old.check_details_page.edit_key_people.click
  people = @old.key_people_page.key_people
  @old.key_people_page.submit_key_person(person: people[0])
  @old.relevant_convictions_page.submit(choice: :no)
  @old.check_details_page.submit
end

When(/^I remove a partner from my registration$/) do
  @old.check_details_page.edit_key_people.click

  @old.key_people_page.remove_person[0].click
  @old.key_people_page.submit_button.click
  @old.relevant_convictions_page.submit(choice: :no)
  @old.check_details_page.submit
end

Then(/^I will not be charged for my change$/) do
  expect(@fo.waste_carrier_registrations_page.heading).to have_text("Your waste carrier registrations")
  expect(@fo.waste_carrier_registrations_page.current_url).to include "/fo"
end

When(/^I change my organisation type to a limited company$/) do
  @old.check_details_page.edit_smart_answers.click
  @journey.location_page.submit(choice: :england)
  @old.old_business_type_page.submit(org_type: "limitedCompany")
  @old.other_businesses_question_page.submit(choice: :yes)
  @old.service_provided_question_page.submit(choice: :not_main_service)
  @old.construction_waste_question_page.submit(choice: :yes)
  @old.registration_type_page.submit(choice: :carrier_dealer)
  @old.business_details_page.submit(
    companies_house_number: "00445790",
    postcode: "BS1 5AH",
    result: "HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH"
  )
  @old.contact_details_page.submit
  @old.postal_address_page.submit
  @old.key_people_page.submit
  @old.relevant_convictions_page.submit(choice: :no)
  @old.check_details_page.submit
end

When(/^its companies house number changes to "([^"]*)"$/) do |ch_no|
  @old.check_details_page.edit_smart_answers.click
  @journey.location_page.submit(choice: :england)
  @old.old_business_type_page.submit
  @old.other_businesses_question_page.submit
  @old.construction_waste_question_page.submit
  @old.registration_type_page.submit
  @old.business_details_page.submit(
    companies_house_number: ch_no,
    postcode: "BS1 5AH",
    result: "HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH"
  )
  @old.contact_details_page.submit
  @old.postal_address_page.submit
  @old.key_people_page.submit
  @old.relevant_convictions_page.submit(choice: :no)
  @old.check_details_page.submit
end

Then(/^(?:I|it) will be charged "([^"]*)" for the change$/) do |charge|
  @actual_charge = "£" + @old.old_order_page.charge.value
  expect(@actual_charge).to eq(charge)
end

Then(/^the charge "([^"]*)" has been paid$/) do |charge|
  @actual_charge = "£" + @old.old_order_page.charge.value
  expect(@actual_charge).to eq(charge)

  @old.old_order_page.submit(
    copy_card_number: "1",
    choice: :card_payment
  )
  submit_valid_card_payment
  expect(@old.old_confirmation_page.confirmation_message).to have_text("Registration complete")
  @new_registration_number = @old.old_confirmation_page.registration_number.text
end

Then(/^its previous registration will be "([^"]*)"$/) do |status|
  Capybara.reset_session!
  @old = OldApp.new
  @bo = BackOfficeApp.new
  @old.agency_sign_in_page.load
  @old.agency_sign_in_page.submit(
    email: Quke::Quke.config.custom["accounts"]["agency-user"]["username"],
    password: ENV["WCRS_DEFAULT_PASSWORD"]
  )
  @old.backend_registrations_page.search(search_input: @reg_number)
  expect(@old.backend_registrations_page.search_results[0].status.text).to eq(status)
end

Then(/^a new registration will be "([^"]*)"$/) do |status|
  @old.agency_sign_in_page.load
  @old.backend_registrations_page.search(search_input: @new_registration_number)
  expect(@old.backend_registrations_page.search_results[0].status.text).to eq(status)
end
