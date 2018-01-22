
Then(/^the expiry date should be three years from the expiry date$/) do
  # Adds three years to expiry date and then checks expiry date reported in registration details
  registration_expiry_date = Date.new(2018, 2, 5)

  @new_expiry_date = registration_expiry_date.next_year(3).strftime("%d/%m/%Y")
  @back_app.registrations_page.search(search_input: @registration_number)
  expect(@back_app.registrations_page.search_results[0].expiry_date.text).to eq(@new_expiry_date)
end

Then(/^I will be shown the renewal information page$/) do
  expect(@renewals_app.renewal_start_page).to have_text(@registration_number)
  expect(@renewals_app.renewal_start_page.current_url).to include "/renewal"
end

When(/^I choose to renew my registration from my registrations list$/) do
  @renewals_app.waste_carrier_registrations_page.user_registrations[0].renew_registration.click
end

Given(/^I choose to renew my registration$/) do
  Capybara.reset_session!
  @renewals_app = FrontOfficeApp.new
  @renewals_app.start_page.load
  @renewals_app.start_page.submit(renewal: true)
  @renewals_app.existing_registration_page.submit(reg_no: @registration_number)
end

When(/^I enter my lower tier registration number "([^"]*)"$/) do |reg_no|
  @renewals_app.existing_registration_page.submit(reg_no: reg_no)
end

Then(/^I'm informed "([^"]*)"$/) do |error_message|
  expect(@renewals_app.existing_registration_page.error_message.text).to eq(error_message)
end

When(/^the organisation type is changed to sole trader$/) do
  @renewals_app.renewal_start_page.submit
  @renewals_app.business_type_page.submit(org_type: "soleTrader")
end

Then(/^I'm informed I'll need to apply for a new registration$/) do
  expect(@renewals_app.type_change_page).to have_text("You cannot renew")
end

Then(/^I will have renewed my registration$/) do
  expect(@renewals_app.confirmation_page).to have_text("Renewal complete")
end

Then(/^a renewal confirmation email is received$/) do
  # resets session cookies to fix back office authentication issue
  Capybara.reset_session!
  @renewals_app = FrontOfficeApp.new
  @renewals_app.mailinator_page.load
  @renewals_app.mailinator_page.submit(inbox: @email)
  @renewals_app.mailinator_inbox_page.renewal_complete_email.click
  @renewals_app.mailinator_inbox_page.email_details do |_frame|
    expect(@renewals_app.confirmation_page).to have_text @registration_number
  end

end

Then(/^I will be informed my renewal is received$/) do
  expect(@renewals_app.renewal_received_page).to have_text("Renewal received")
  expect(@renewals_app.renewal_received_page).to have_text(@registration_number)
end

When(/^I change my registration type to "([^"]*)" and complete my renewal$/) do |registration_type|
  @renewals_app.renewal_start_page.submit
  @renewals_app.business_type_page.submit
  @renewals_app.other_businesses_question_page.submit(choice: :yes)
  @renewals_app.service_provided_page.submit(choice: :main_service)
  @renewals_app.waste_types_page.submit(choice: :not_farm_waste)
  @renewals_app.registration_type_page.submit(choice: registration_type.to_sym)
  @renewals_app.renewal_information_page.submit
  @renewals_app.company_name_page.submit
  @renewals_app.post_code_page.submit(postcode: "S60 1BY")
  @renewals_app.business_address_page.submit(
    result: "ENVIRONMENT AGENCY, BOW BRIDGE CLOSE, ROTHERHAM, S60 1BY"
  )
  @renewals_app.contact_details_page.submit
  @renewals_app.postal_address_page.submit

  people = @renewals_app.key_people_page.key_people
  @renewals_app.key_people_page.add_key_person(person: people[0])
  @renewals_app.key_people_page.add_key_person(person: people[1])
  @renewals_app.key_people_page.submit_key_person(person: people[2])

  @renewals_app.relevant_convictions_page.submit(choice: :no)
  @renewals_app.declaration_page.submit
end

Then(/^I'll be shown the "([^"]*)" renewal charge plus the "([^"]*)" charge for change$/) do |renewal, change|
  @actual_charge = "£" + @renewals_app.order_page.charge.value
  expect(@actual_charge).to eq(renewal)
  @renewal_charge = "£" + @renewals_app.order_page.edit_charge.value
  expect(@actual_charge).to eq(change)
end

When(/^I answer questions indicating I should be a lower tier waste carrier$/) do
  @renewals_app.renewal_start_page.submit
  @renewals_app.business_type_page.submit
  @renewals_app.other_businesses_question_page.submit(choice: :yes)
  @renewals_app.service_provided_page.submit(choice: :not_main_service)
  @renewals_app.construction_waste_question_page.submit(choice: :no)
end

Then(/^I will be informed I should not renew my upper tier waste carrier registration$/) do
  expect(@renewals_app.renewal_received_page).to have_text("You should not renew")
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
  @renewals_app.other_businesses_question_page.submit(choice: :no)
  @renewals_app.construction_waste_question_page.submit(choice: :yes)
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

Then(/^I will be able to continue my renewal$/) do
  expect(@renewals_app.other_businesses_question_page.current_url).to include "/other-businesses"
end

When(/^I complete my sole trader renewal steps$/) do
  @renewals_app.renewal_start_page.submit
  @renewals_app.business_type_page.submit
  @renewals_app.other_businesses_question_page.submit(choice: :yes)
  @renewals_app.service_provided_page.submit(choice: :not_main_service)
  @renewals_app.construction_waste_question_page.submit(choice: :yes)
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
  @renewals_app.other_businesses_question_page.submit(choice: :yes)
  @renewals_app.service_provided_page.submit(choice: :main_service)
  @renewals_app.waste_types_page.submit(choice: :not_farm_waste)
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
  @renewals_app.other_businesses_question_page.submit(choice: :yes)
  @renewals_app.service_provided_page.submit(choice: :not_main_service)
  @renewals_app.construction_waste_question_page.submit(choice: :yes)
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

When(/^I complete my partnership renewal steps$/) do
  @renewals_app.renewal_start_page.submit
  @renewals_app.business_type_page.submit
  @renewals_app.other_businesses_question_page.submit(choice: :yes)
  @renewals_app.service_provided_page.submit(choice: :main_service)
  @renewals_app.waste_types_page.submit(choice: :not_farm_waste)
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

When(/^I complete my overseas company renewal steps$/) do
  @renewals_app.renewal_start_page.submit
  @renewals_app.business_type_page.submit
  @renewals_app.other_businesses_question_page.submit(choice: :no)
  @renewals_app.construction_waste_question_page.submit(choice: :yes)
  @renewals_app.registration_type_page.submit
  @renewals_app.renewal_information_page.submit
  @renewals_app.company_name_page.submit
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

When(/^I confirm my business type$/) do
  @renewals_app.renewal_start_page.submit
  @renewals_app.business_type_page.submit
end

Then(/^I will be notified "([^"]*)"$/) do |message|
  expect(@renewals_app.cannot_renew_lower_tier_page).to have_text(message)
end

Given(/^I have an upper tier waste carrier licence$/) do
  # No code to write here, step added so the test reads better
end

When(/^the renewal date is over one month before it is due to expire$/) do
  # No code to write here, step added so the test reads better
end

When(/^the renewal date is today$/) do
  # No code to write here, step added so the test reads better
end
