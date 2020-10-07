# All these steps can be archived when we have removed the old apps in production

Given(/^I start a new registration on the frontend$/) do
  # This step covers a registration from the old app.
  @old = OldApp.new
  @journey = JourneyApp.new
  @old.old_start_page.load
  @old.old_start_page.submit
  # Redirects to "Where is your principal place of business?"
  expect(@journey.location_page.heading).to have_text("Where is your principal place of business?")
  # Select England as the principal place of business:
  @journey.location_page.submit(choice: :england)
end

When(/^I complete my application of my limited company as an upper tier waste carrier$/) do
  @old.old_business_type_page.submit(org_type: "limitedCompany")
  @old.other_businesses_question_page.submit(choice: :no)
  @old.construction_waste_question_page.submit(choice: :yes)
  @old.registration_type_page.submit(choice: :carrier_broker_dealer)
  @old.business_details_page.submit(
    companies_house_number: "00445790",
    company_name: "UT Company limited",
    postcode: "BS1 5AH",
    result: "HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH"
  )
  @email_address = generate_email
  @old.contact_details_page.submit(
    first_name: "Bob",
    last_name: "Carolgees",
    phone_number: "0117 4960000",
    email: @email_address
  )
  @old.postal_address_page.submit

  people = @old.key_people_page.key_people

  @old.key_people_page.add_key_person(person: people[0])
  @old.key_people_page.add_key_person(person: people[1])
  @old.key_people_page.submit_key_person(person: people[2])

  @old.relevant_convictions_page.submit(choice: :no)
  @old.check_details_page.submit
  @old.sign_up_page.submit(
    registration_password: ENV["WCRS_DEFAULT_PASSWORD"],
    confirm_password: ENV["WCRS_DEFAULT_PASSWORD"],
    confirm_email: @email_address
  )
end

When(/^I pay for my application by maestro ordering (\d+) copy (?:card|cards)$/) do |copy_card_number|
  @old.old_order_page.submit(
    copy_card_number: copy_card_number,
    choice: :card_payment
  )

  submit_valid_card_payment

  @reg_number = find("#registrationNumber").text
  puts "Registration " + @reg_number + " completed by card"
end

Then(/^I will be registered as an upper tier waste carrier$/) do
  expect(@old.old_confirmation_page.registration_number).to have_text("CBDU")
  expect(@old.old_confirmation_page).to have_text @email_address
  # Stores registration number for later use
  @reg_number = @old.old_confirmation_page.registration_number.text
  puts "Upper tier registration " + @reg_number + " completed"
end

When(/^I choose to pay for my application by bank transfer ordering (\d+) copy (?:card|cards)$/) do |copy_card_number|
  @old.old_order_page.submit(
    copy_card_number: copy_card_number,
    choice: :bank_transfer_payment
  )
  @old.offline_payment_page.submit
end

Then(/^I will be informed my registration is pending payment$/) do
  expect(@old.old_confirmation_page).to have_text "Application received"
  expect(@old.old_confirmation_page).to have_text @email_address
  # Stores registration number for later use
  @reg_number = @old.old_confirmation_page.registration_number.text
end
