Given(/^I renew my registration using my previous registration number "([^"]*)"$/) do |reg|
  @front_app = FrontOfficeApp.new
  @front_app.start_page.load
  @front_app.start_page.submit(renewal: true)
  @front_app.existing_registration_page.submit(reg_no: reg)
end

Given(/^I choose to renew my registration using my previous registration number$/) do
  Capybara.reset_session!
  @front_app = FrontOfficeApp.new
  @front_app.start_page.load
  @front_app.start_page.submit(renewal: true)
  @front_app.existing_registration_page.submit(reg_no: @registration_number)
end

When(/^I complete the public body registration renewal$/) do
  @front_app.business_type_page.submit
  @front_app.other_businesses_question_page.submit(choice: :no)
  @front_app.construction_waste_question_page.submit(choice: :yes)
  @front_app.registration_type_page.submit
  @front_app.business_details_page.submit(
    postcode: "BS1 5AH",
    result: "ENVIRONMENT AGENCY, HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH"
  )
  @email = @front_app.generate_email
  @front_app.contact_details_page.submit(
    first_name: "Bob",
    last_name: "Carolgees",
    phone_number: "012345678",
    email: @email
  )
  @front_app.postal_address_page.submit

  people = @front_app.key_people_page.key_people

  @front_app.key_people_page.submit_key_person(person: people[0])
  @front_app.relevant_convictions_page.submit(choice: :no)
  @front_app.declaration_page.submit
  @front_app.sign_up_page.submit(
    registration_password: "Secret123",
    confirm_password: "Secret123",
    confirm_email: @email
  )
  @front_app.order_page.submit(
    copy_card_number: "2",
    choice: :card_payment
  )
  @front_app.worldpay_card_choice_page.maestro.click

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
  # Stores registration number for later use
  @registration_number = @front_app.registration_confirmed_page.registration_number.text
  @front_app.mailinator_page.load
  @front_app.mailinator_page.submit(inbox: @email)
  @front_app.mailinator_inbox_page.confirmation_email.click
  @front_app.mailinator_inbox_page.email_details do |frame|
    @new_window = window_opened_by { frame.confirm_email.click }
  end
end

Then(/^the expiry date should be three years from the expiry date$/) do
  # Adds three years to expiry date and then checks expiry date reported in registration details
  registration_expiry_date = Date.new(2018, 2, 5)

  @new_expiry_date = registration_expiry_date.next_year(3).strftime("%d/%m/%Y")
  @back_app.registrations_page.search(search_input: @registration_number)
  expect(@back_app.registrations_page.search_results[0].expiry_date.text).to eq(@new_expiry_date)
end

Then(/^I will be shown the renewal information page$/) do
  expect(@front_app.renewal_introduction_page).to have_text(@registration_number)
  expect(@front_app.renewal_introduction_page.current_url).to include "/renewal"
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

Then(/^I'm told "([^"]*)"$/) do |error_message|
  expect(@front_app.existing_registration_page.error_message.text).to eq(error_message)
end
