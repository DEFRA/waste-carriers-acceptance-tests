
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

When(/^I change my carrier broker dealer type to "([^"]*)"$/) do |registration_type|
  @renewals_app.renewal_start_page.submit
  @renewals_app.business_type_page.submit
  @renewals_app.other_businesses_page.submit(choice: :yes)
  @renewals_app.service_provided_page.submit(choice: :main_service)
  @renewals_app.waste_types_page.submit(choice: :not_farm_waste)
  @renewals_app.registration_type_page.submit(choice: registration_type.to_sym)
end

When(/^I answer questions indicating I should be a lower tier waste carrier$/) do
  @renewals_app.renewal_start_page.submit
  @renewals_app.business_type_page.submit
  @renewals_app.other_businesses_page.submit(choice: :yes)
  @renewals_app.service_provided_page.submit(choice: :not_main_service)
  @renewals_app.construction_waste_page.submit(choice: :no)
end

Given(/^I have signed in to renew my registration$/) do
  @renewals_app = RenewalsApp.new
  @renewals_app.waste_carriers_renewals_sign_in_page.load
  @renewals_app.waste_carriers_renewals_sign_in_page.submit(
    email: Quke::Quke.config.custom["accounts"]["waste_carrier"]["username"],
    password: ENV["WASTECARRIERSPASSWORD"]
  )
  expect(@renewals_app.waste_carriers_renewals_page.text).to have_text "Listing Registrations"
end

Given(/^I have chosen registration "([^"]*)" ready for renewal$/) do |number|
  visit("/renew/#{number}")
end

When(/^I complete my limited company renewal steps$/) do
  @renewals_app.renewal_start_page.submit
  @renewals_app.business_type_page.submit
  @renewals_app.other_businesses_page.submit(choice: :no)
  @renewals_app.construction_waste_page.submit(choice: :yes)
  @renewals_app.registration_type_page.submit
  @renewals_app.renewal_information_page.submit
  @renewals_app.registration_number_page.submit
  @renewals_app.company_name_page.submit
  @renewals_app.post_code_page.submit
  @renewals_app.business_address_page.submit
  @renewals_app.renew_key_people_page.submit
  @renewals_app.relevant_convictions_page.submit
  @renewals_app.renew_relevant_people_page.submit
  @renewals_app.contact_name_page.submit
  @renewals_app.contact_telephone_number_page.submit
  @renewals_app.contact_email_page.submit
  @renewals_app.contact_address_page.submit
  @renewals_app.check_your_answers_page.submit
  @renewals_app.declaration_page.submit
  @renewals_app.payment_summary_page.submit
  @renewals_app.worldpay_card_details_page.submit_button.click
end

Given(/^I change the business type to "([^"]*)"$/) do |org_type|
  @renewals_app.renewal_start_page.submit
  @renewals_app.business_type_page.wait_for_new_org_types
  @renewals_app.business_type_page.submit(new_org_type: org_type)
end

Then(/^I will be able to continue my renewal$/) do
  @renewals_app.other_businesses_page.wait_for_yes_other_businesses
  expect(@renewals_app.other_businesses_page.current_url).to include "/other-businesses"
  visit("/users/sign_out")
end

When(/^I complete my sole trader renewal steps$/) do
  @renewals_app.renewal_start_page.submit
  @renewals_app.business_type_page.submit
  @renewals_app.other_businesses_page.submit(choice: :yes)
  @renewals_app.service_provided_page.submit(choice: :not_main_service)
  @renewals_app.construction_waste_page.submit(choice: :yes)
  @renewals_app.registration_type_page.submit
  @renewals_app.renewal_information_page.submit
  @renewals_app.company_name_page.submit
  @renewals_app.post_code_page.submit
  @renewals_app.business_address_page.submit
  @renewals_app.renew_key_people_page.submit
  @renewals_app.relevant_convictions_page.submit
  @renewals_app.renew_relevant_people_page.submit
  @renewals_app.contact_name_page.submit
  @renewals_app.contact_telephone_number_page.submit
  @renewals_app.contact_email_page.submit
  @renewals_app.contact_address_page.submit
  @renewals_app.check_your_answers_page.submit
  @renewals_app.declaration_page.submit
  @renewals_app.payment_summary_page.submit
  @renewals_app.worldpay_card_details_page.submit_button.click
end

When(/^I complete my local authority renewal steps$/) do
  @renewals_app.renewal_start_page.submit
  @renewals_app.business_type_page.submit
  @renewals_app.other_businesses_page.submit(choice: :yes)
  @renewals_app.service_provided_page.submit(choice: :main_service)
  @renewals_app.waste_types_page.submit(choice: :not_farm_waste)
  @renewals_app.registration_type_page.submit
  @renewals_app.renewal_information_page.submit
  @renewals_app.company_name_page.submit
  @renewals_app.post_code_page.submit
  @renewals_app.business_address_page.submit
  @renewals_app.renew_key_people_page.submit
  @renewals_app.relevant_convictions_page.submit
  @renewals_app.renew_relevant_people_page.submit
  @renewals_app.contact_name_page.submit
  @renewals_app.contact_telephone_number_page.submit
  @renewals_app.contact_email_page.submit
  @renewals_app.contact_address_page.submit
  @renewals_app.check_your_answers_page.submit
  @renewals_app.declaration_page.submit
  @renewals_app.payment_summary_page.submit
  @renewals_app.worldpay_card_details_page.submit_button.click
end

When(/^I complete my limited liability partnership renewal steps$/) do
  @renewals_app.renewal_start_page.submit
  @renewals_app.business_type_page.submit
  @renewals_app.other_businesses_page.submit(choice: :yes)
  @renewals_app.service_provided_page.submit(choice: :not_main_service)
  @renewals_app.construction_waste_page.submit(choice: :yes)
  @renewals_app.registration_type_page.submit
  @renewals_app.renewal_information_page.submit
  @renewals_app.registration_number_page.submit
  @renewals_app.company_name_page.submit
  @renewals_app.post_code_page.submit
  @renewals_app.business_address_page.submit
  @renewals_app.renew_key_people_page.submit
  @renewals_app.relevant_convictions_page.submit
  @renewals_app.renew_relevant_people_page.submit
  @renewals_app.contact_name_page.submit
  @renewals_app.contact_telephone_number_page.submit
  @renewals_app.contact_email_page.submit
  @renewals_app.contact_address_page.submit
  @renewals_app.check_your_answers_page.submit
  @renewals_app.declaration_page.submit
  @renewals_app.payment_summary_page.submit
  @renewals_app.worldpay_card_details_page.submit_button.click
end

When(/^I complete my partnership renewal steps$/) do
  @renewals_app.renewal_start_page.submit
  @renewals_app.business_type_page.submit
  @renewals_app.other_businesses_page.submit(choice: :yes)
  @renewals_app.service_provided_page.submit(choice: :main_service)
  @renewals_app.waste_types_page.submit(choice: :not_farm_waste)
  @renewals_app.registration_type_page.submit
  @renewals_app.renewal_information_page.submit
  @renewals_app.company_name_page.submit
  @renewals_app.post_code_page.submit
  @renewals_app.business_address_page.submit
  @renewals_app.renew_key_people_page.submit
  @renewals_app.relevant_convictions_page.submit
  @renewals_app.renew_relevant_people_page.submit
  @renewals_app.contact_name_page.submit
  @renewals_app.contact_telephone_number_page.submit
  @renewals_app.contact_email_page.submit
  @renewals_app.contact_address_page.submit
  @renewals_app.check_your_answers_page.submit
  @renewals_app.declaration_page.submit
  @renewals_app.payment_summary_page.submit
  @renewals_app.worldpay_card_details_page.submit_button.click
end

When(/^I complete my overseas company renewal steps$/) do
  @renewals_app.renewal_start_page.submit
  @renewals_app.business_type_page.submit
  @renewals_app.other_businesses_page.submit(choice: :no)
  @renewals_app.construction_waste_page.submit(choice: :yes)
  @renewals_app.registration_type_page.submit
  @renewals_app.renewal_information_page.submit
  @renewals_app.company_name_page.submit
  @renewals_app.business_address_page.submit
  @renewals_app.renew_key_people_page.submit
  @renewals_app.relevant_convictions_page.submit
  @renewals_app.renew_relevant_people_page.submit
  @renewals_app.contact_name_page.submit
  @renewals_app.contact_telephone_number_page.submit
  @renewals_app.contact_email_page.submit
  @renewals_app.contact_address_page.submit
  @renewals_app.check_your_answers_page.submit
  @renewals_app.declaration_page.submit
  @renewals_app.payment_summary_page.submit
  @renewals_app.worldpay_card_details_page.submit_button.click
end

When(/^I confirm my business type$/) do
  @renewals_app.renewal_start_page.submit
  @renewals_app.business_type_page.submit
end

Then(/^I will be notified "([^"]*)"$/) do |message|
  expect(@renewals_app.cannot_renew_lower_tier_page).to have_text(message)
  visit("/users/sign_out")
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

Given(/^I change my companies house number to "([^"]*)"$/) do |number|
  @renewals_app.renewal_start_page.submit
  @renewals_app.business_type_page.submit
  @renewals_app.other_businesses_page.submit(choice: :yes)
  @renewals_app.service_provided_page.submit(choice: :not_main_service)
  @renewals_app.construction_waste_page.submit(choice: :yes)
  @renewals_app.registration_type_page.submit
  @renewals_app.renewal_information_page.submit
  @renewals_app.registration_number_page.submit(companies_house_number: number)
end
