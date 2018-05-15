
Given(/I choose to edit my registration "([^"]*)"$/) do |regNo|
  Capybara.reset_session!
  @front_app = FrontOfficeApp.new
  @front_app.waste_carrier_sign_in_page.load
  @front_app.waste_carrier_sign_in_page.submit(
    email: Quke::Quke.config.custom["accounts"]["waste_carrier"]["username"],
    password: ENV["WASTECARRIERSPASSWORD"]
  )
  @front_app.waste_carrier_registrations_page.edit(reg: regNo)
  @registration_number = regNo
end

When(/^I change my registration type to "([^"]*)"$/) do |registration_type|
  @front_app.check_details_page.edit_registration_type.click
  @front_app.registration_type_page.submit(choice: registration_type.to_sym)
  @front_app.check_details_page.submit
end

When(/^I add another partner to my registration$/) do
  @front_app.check_details_page.edit_key_people.click
  people = @front_app.key_people_page.key_people
  @front_app.key_people_page.submit_key_person(person: people[0])
  @front_app.relevant_convictions_page.submit(choice: :no)
  @front_app.check_details_page.submit
end

When(/^I remove a partner from my registration$/) do
  @front_app.check_details_page.edit_key_people.click

  @front_app.key_people_page.remove_person[0].click
  @front_app.key_people_page.submit_button.click
  @front_app.relevant_convictions_page.submit(choice: :no)
  @front_app.check_details_page.submit
end

Then(/^I will not be charged for my change$/) do
  expect(@front_app.waste_carrier_registrations_page.current_url).to include "/registrations"
end

When(/^I change my organisation type to a limited company$/) do
  @front_app.check_details_page.edit_smart_answers.click
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
  @front_app.check_details_page.submit
end

When(/^its companies house number changes to "([^"]*)"$/) do |ch_no|
  @front_app.check_details_page.edit_smart_answers.click
  @front_app.business_type_page.submit
  @front_app.other_businesses_question_page.submit
  @front_app.construction_waste_question_page.submit
  @front_app.registration_type_page.submit
  @front_app.business_details_page.submit(companies_house_number: ch_no)
  @front_app.contact_details_page.submit
  @front_app.postal_address_page.submit
  @front_app.key_people_page.submit
  @front_app.relevant_convictions_page.submit(choice: :no)
  @front_app.check_details_page.submit
end

Then(/^(?:I|it) will be charged "([^"]*)" for the change$/) do |charge|
  @actual_charge = "£" + @front_app.order_page.charge.value
  expect(@actual_charge).to eq(charge)
end

Then(/^the charge "([^"]*)" has been paid$/) do |charge|
  @actual_charge = "£" + @front_app.order_page.charge.value
  expect(@actual_charge).to eq(charge)

  @front_app.order_page.submit(
    copy_card_number: "1",
    choice: :card_payment
  )
  click(@front_app.worldpay_card_choice_page.maestro)

  # finds today's date and adds another year to expiry date
  time = Time.new

  @year = time.year + 1

  @front_app.worldpay_card_details_page.submit(
    card_number: "6759649826438453",
    security_code: "555",
    cardholder_name: "3d.authorised",
    expiry_month: "12",
    expiry_year: @year
  )
  @front_app.worldpay_card_details_page.submit_button.click
  @new_registration_number = @front_app.confirmation_page.registration_number.text
end

Then(/^its previous registration will be "([^"]*)"$/) do |status|
  Capybara.reset_session!
  @back_app = BackOfficeApp.new
  @back_app.agency_sign_in_page.load
  @back_app.agency_sign_in_page.submit(
    email: Quke::Quke.config.custom["accounts"]["agency_user"]["username"],
    password: ENV["WASTECARRIERSPASSWORD"]
  )
  @back_app.registrations_page.search(search_input: @registration_number)
  expect(@back_app.registrations_page.search_results[0].status.text).to eq(status)
end

Then(/^a new registration will be "([^"]*)"$/) do |status|
  @back_app.agency_sign_in_page.load
  @back_app.registrations_page.search(search_input: @new_registration_number)
  expect(@back_app.registrations_page.search_results[0].status.text).to eq(status)
end
