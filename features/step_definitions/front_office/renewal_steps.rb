
Then(/^the expiry date should be three years from the expiry date$/) do
  # Adds three years to expiry date and then checks expiry date reported in registration details
  registration_expiry_date = Date.new(2018, 2, 5)

  @new_expiry_date = registration_expiry_date.next_year(3).strftime("%d/%m/%Y")
  @back_app.registrations_page.search(search_input: @registration_number)
  expect(@back_app.registrations_page.search_results[0].expiry_date.text).to eq(@new_expiry_date)
end

Then(/^I will be shown the renewal information page$/) do
  expect(@front_app.renewal_start_page).to have_text(@registration_number)
  expect(@front_app.renewal_start_page.current_url).to include "/renewal"
end

When(/^I choose to renew my registration from my registrations list$/) do
  @front_app.waste_carrier_registrations_page.user_registrations[0].renew_registration.click
end

Given(/^I choose to renew my registration$/) do
  Capybara.reset_session!
  @front_app = FrontOfficeApp.new
  @front_app.start_page.load
  @front_app.start_page.submit(renewal: true)
  @front_app.existing_registration_page.submit(reg_no: @registration_number)
end

When(/^I enter my lower tier registration number "([^"]*)"$/) do |reg_no|
  @front_app.existing_registration_page.submit(reg_no: reg_no)
end

Then(/^I'm informed "([^"]*)"$/) do |error_message|
  expect(@front_app.existing_registration_page.error_message.text).to eq(error_message)
end

When(/^the organisation type is changed to sole trader$/) do
  @front_app.renewal_start_page.submit
  @front_app.business_type_page.submit(org_type: "soleTrader")
end

Then(/^I'm informed I'll need to apply for a new registration$/) do
  expect(@front_app.type_change_page).to have_text("You cannot renew")
end

Then(/^I will have renewed my registration$/) do
  expect(@front_app.confirmation_page).to have_text("Renewal complete")
end

Then(/^a renewal confirmation email is received$/) do
  # resets session cookies to fix back office authentication issue
  Capybara.reset_session!
  @front_app = FrontOfficeApp.new
  @front_app.mailinator_page.load
  @front_app.mailinator_page.submit(inbox: @email)
  @front_app.mailinator_inbox_page.renewal_complete_email.click
  @front_app.mailinator_inbox_page.email_details do |_frame|
    expect(@front_app.confirmation_page).to have_text @registration_number
  end

end

Then(/^I will be informed my renewal is received$/) do
  expect(@front_app.renewal_received_page).to have_text("Renewal received")
  expect(@front_app.renewal_received_page).to have_text(@registration_number)
end

When(/^I change my registration type to "([^"]*)" and complete my renewal$/) do |registration_type|
  @front_app.renewal_start_page.submit
  @front_app.business_type_page.submit
  @front_app.other_businesses_question_page.submit(choice: :yes)
  @front_app.service_provided_question_page.submit(choice: :main_service)
  @front_app.only_deal_with_question_page.submit(choice: :not_farm_waste)
  @front_app.registration_type_page.submit(choice: registration_type.to_sym)
  @front_app.renewal_information_page.submit
  @front_app.company_name_page.submit
  @front_app.post_code_page.submit(postcode: "S60 1BY")
  @front_app.business_address_page.submit(
    result: "ENVIRONMENT AGENCY, BOW BRIDGE CLOSE, ROTHERHAM, S60 1BY"
  )
  @front_app.contact_details_page.submit
  @front_app.postal_address_page.submit

  people = @front_app.key_people_page.key_people
  @front_app.key_people_page.add_key_person(person: people[0])
  @front_app.key_people_page.add_key_person(person: people[1])
  @front_app.key_people_page.submit_key_person(person: people[2])

  @front_app.relevant_convictions_page.submit(choice: :no)
  @front_app.declaration_page.submit
end

Then(/^I'll be shown the "([^"]*)" renewal charge plus the "([^"]*)" charge for change$/) do |renewal, change|
  @actual_charge = "£" + @front_app.order_page.charge.value
  expect(@actual_charge).to eq(renewal)
  @renewal_charge = "£" + @front_app.order_page.edit_charge.value
  expect(@actual_charge).to eq(change)
end

When(/^I answer questions indicating I should be a lower tier waste carrier$/) do
  @front_app.renewal_start_page.submit
  @front_app.business_type_page.submit
  @front_app.other_businesses_question_page.submit(choice: :yes)
  @front_app.service_provided_question_page.submit(choice: :not_main_service)
  @front_app.construction_waste_question_page.submit(choice: :no)
  @front_app.registration_type_page.submit
end

Then(/^I will be informed I should not renew my upper tier waste carrier registration$/) do
  expect(@front_app.renewal_received_page).to have_text("You should not renew")
end

Given(/^I have signed in to renew my registration$/) do
  @renewals_app = RenewalsApp.new
  @renewals_app.waste_carriers_renewals_sign_in_page.load
  @renewals_app.waste_carriers_renewals_sign_in_page.submit(
    email: Quke::Quke.config.custom["accounts"]["waste_carrier"]["username"],
    password: ENV["WASTECARRIERSPASSWORD"]
  )
end

Given(/^I have chosen registration "([^"]*)" ready for renewal$/) do |number|
  @renewals_app.waste_carriers_renewals_page.registration(number).renew_registration.click
end

When(/^I complete my limited company renewal steps$/) do
  @renewals_app.renewal_start_page.submit
  @renewals_app.business_type_page.submit
  @renewals_app.other_businesses_question_page.submit
  @renewals_app.registration_type_page.submit
  @renewals_app.renewal_information_page.submit
  @renewals_app.registration_number_page.submit
  @renewals_app.company_name_page.submit
  @renewals_app.post_code_page.submit
  @renewals_app.business_address_page.submit
  @renewals_app.key_people_page.submit
  @renewals_app.relevant_convictions_page.submit
  @renewals_app.relevant_people_page.submit
  @renewals_app.contact_name_page.submit
  @renewals_app.contact_telephone_number_page.submit
  @renewals_app.contact_email_page.submit
  @renewals_app.contact_address_page.submit
  @renewals_app.check_your_answers_page.submit
  @renewals_app.declaration_page.submit
  @renewals_app.payment_summary_page.submit
  @renewals_app.worldpay_card_details_page.submit
end

Then(/^I will be notified that my registration has been renewed$/) do
  expect(@renewals_app.renewal_complete_page).to have_text("Renewal complete")
end

Given(/^I change the business type to "([^"]*)"$/) do |org_type|
  @renewals_app.renewal_start_page.submit
  @renewals_app.business_type_page.submit(new_org_type: org_type)
end

Then(/^I will be notified that I'm unable to continue my renewal$/) do
  expect(@renewals_app.cannot_renewal_type_change_page).to have_text("You cannot renew")
end

Then(/^I will be able to continue my renewal$/) do
  expect(@renewals_app.other_businesses_question_page.current_url).to include "/smart-answers"
end

When(/^I complete my sole trader renewal steps$/) do
  @renewals_app.renewal_start_page.submit
  @renewals_app.business_type_page.submit
  @renewals_app.other_businesses_question_page.submit
  @renewals_app.registration_type_page.submit
  @renewals_app.renewal_information_page.submit
  @renewals_app.company_name_page.submit
  @renewals_app.post_code_page.submit
  @renewals_app.business_address_page.submit
  @renewals_app.key_people_page.submit
  @renewals_app.relevant_convictions_page.submit
  @renewals_app.relevant_people_page.submit
  @renewals_app.contact_name_page.submit
  @renewals_app.contact_telephone_number_page.submit
  @renewals_app.contact_email_page.submit
  @renewals_app.contact_address_page.submit
  @renewals_app.check_your_answers_page.submit
  @renewals_app.declaration_page.submit
  @renewals_app.payment_summary_page.submit
  @renewals_app.worldpay_card_details_page.submit
end

When(/^I complete my local authority renewal steps$/) do
  @renewals_app.renewal_start_page.submit
  @renewals_app.business_type_page.submit
  @renewals_app.other_businesses_question_page.submit
  @renewals_app.registration_type_page.submit
  @renewals_app.renewal_information_page.submit
  @renewals_app.company_name_page.submit
  @renewals_app.post_code_page.submit
  @renewals_app.business_address_page.submit
  @renewals_app.key_people_page.submit
  @renewals_app.relevant_convictions_page.submit
  @renewals_app.relevant_people_page.submit
  @renewals_app.contact_name_page.submit
  @renewals_app.contact_telephone_number_page.submit
  @renewals_app.contact_email_page.submit
  @renewals_app.contact_address_page.submit
  @renewals_app.check_your_answers_page.submit
  @renewals_app.declaration_page.submit
  @renewals_app.payment_summary_page.submit
  @renewals_app.worldpay_card_details_page.submit
end

When(/^I complete my limited liability partnership renewal steps$/) do
  @renewals_app.renewal_start_page.submit
  @renewals_app.business_type_page.submit
  @renewals_app.other_businesses_question_page.submit
  @renewals_app.registration_type_page.submit
  @renewals_app.renewal_information_page.submit
  @renewals_app.registration_number_page.submit
  @renewals_app.company_name_page.submit
  @renewals_app.post_code_page.submit
  @renewals_app.business_address_page.submit
  @renewals_app.key_people_page.submit
  @renewals_app.relevant_convictions_page.submit
  @renewals_app.relevant_people_page.submit
  @renewals_app.contact_name_page.submit
  @renewals_app.contact_telephone_number_page.submit
  @renewals_app.contact_email_page.submit
  @renewals_app.contact_address_page.submit
  @renewals_app.check_your_answers_page.submit
  @renewals_app.declaration_page.submit
  @renewals_app.payment_summary_page.submit
  @renewals_app.worldpay_card_details_page.submit
end
