When(/^I change my registration type to "([^"]*)"$/) do |registration_type|
  @front_app.mailinator_page.load
  @front_app.mailinator_page.submit(inbox: @email)
  @front_app.mailinator_inbox_page.confirmation_email.click
  @front_app.mailinator_inbox_page.email_details do |frame|
    @new_window = window_opened_by { frame.confirm_email.click }
  end
  @front_app.waste_carrier_sign_in_page.load
  @front_app.waste_carrier_sign_in_page.submit(
    email: @email,
    password: "Secret123"
  )
  @front_app.waste_carrier_registrations_page.user_registrations[0].edit_registration.click
  @front_app.declaration_page.edit_registration_type.click
  @front_app.registration_type_page.submit(choice: registration_type.to_sym)
  @front_app.declaration_page.submit
end

When(/^I add another partner to my registration$/) do
  @front_app.waste_carrier_sign_in_page.load
  @front_app.waste_carrier_sign_in_page.submit(
    email: @email,
    password: "Secret123"
  )
  @front_app.waste_carrier_registrations_page.user_registrations[0].edit_registration.click
  @front_app.declaration_page.edit_key_people.click
  people = @front_app.key_people_page.key_people
  @front_app.key_people_page.submit_key_person(person: people[0])
  @front_app.relevant_convictions_page.submit(choice: :no)
  @front_app.declaration_page.submit
end

When(/^I remove a partner from my registration$/) do
  @front_app.waste_carrier_sign_in_page.load
  @front_app.waste_carrier_sign_in_page.submit(
    email: @email,
    password: "Secret123"
  )
  @front_app.waste_carrier_registrations_page.user_registrations[0].edit_registration.click
  @front_app.declaration_page.edit_key_people.click

  @front_app.key_people_page.remove_person[0].click
  @front_app.key_people_page.submit_button.click
  @front_app.relevant_convictions_page.submit(choice: :no)
  @front_app.declaration_page.submit
end

Then(/^I will not be charged for my change$/) do
  expect(@front_app.waste_carrier_registrations_page.current_url).to include "/registrations"
end

Then(/^I will be charged "([^"]*)" for the change$/) do |charge|
  @actual_charge = "£" + @front_app.order_page.charge.value
  expect(@actual_charge).to eq(charge)
end

When(/^I change my organisation type to a limited company$/) do
  @front_app.waste_carrier_sign_in_page.load
  @front_app.waste_carrier_sign_in_page.submit(
    email: @email,
    password: "Secret123"
  )
  @front_app.waste_carrier_registrations_page.user_registrations[0].edit_registration.click
  @front_app.declaration_page.edit_smart_answers.click
  @front_app.business_type_page.submit(org_type: "limitedCompany")
  @front_app.other_businesses_question_page.submit(choice: :yes)
  @front_app.service_provided_question_page.submit(choice: :not_main_service)
  @front_app.construction_waste_question_page.submit(choice: :yes)
  @front_app.registration_type_page.submit(choice: :carrier_dealer)
  @front_app.business_details_page.submit(companies_house_number: "00233462")
  @front_app.contact_details_page.submit
  @front_app.postal_address_page.submit
  @front_app.key_people_page.submit
  @front_app.relevant_convictions_page.submit(choice: :no)
  @front_app.declaration_page.submit
end
