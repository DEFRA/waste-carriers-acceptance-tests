# rubocop:disable Metrics/BlockLength
When(/^I complete my application of my partnership as a upper tier waste carrier$/) do
  @old.old_business_type_page.submit(org_type: "partnership")
  @old.other_businesses_question_page.submit(choice: :yes)
  @old.service_provided_question_page.submit(choice: :main_service)
  @old.only_deal_with_question_page.submit(choice: :not_farm_waste)
  @old.registration_type_page.submit(choice: :broker_dealer)
  @old.business_details_page.submit(
    company_name: "Upper Tier Partnership",
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

When(/^I complete my application of my public body as an upper tier waste carrier$/) do
  @old.old_business_type_page.submit(org_type: "publicBody")
  @old.other_businesses_question_page.submit(choice: :yes)
  @old.service_provided_question_page.submit(choice: :not_main_service)
  @old.construction_waste_question_page.submit(choice: :yes)
  @old.registration_type_page.submit(choice: :carrier_broker_dealer)
  @old.business_details_page.submit(
    company_name: "UT Public Body",
    postcode: "BS1 5AH",
    result: "HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH"
  )

  @email_address = generate_email
  @old.contact_details_page.submit(
    first_name: "Bob",
    last_name: "Debuilder",
    phone_number: "0117 4960000",
    email: @email_address
  )
  @old.postal_address_page.submit

  people = @old.key_people_page.key_people
  @old.key_people_page.submit_key_person(person: people[0])

  @old.relevant_convictions_page.submit(choice: :no)
  @old.check_details_page.submit
  @old.sign_up_page.submit(
    registration_password: ENV["WCRS_DEFAULT_PASSWORD"],
    confirm_password: ENV["WCRS_DEFAULT_PASSWORD"],
    confirm_email: @email_address
  )
end

When(/^I complete my application of my sole trader business as a upper tier waste carrier$/) do
  @old.old_business_type_page.submit(org_type: "soleTrader")
  @old.other_businesses_question_page.submit(choice: :yes)
  @old.service_provided_question_page.submit(choice: :not_main_service)
  @old.construction_waste_question_page.submit(choice: :yes)
  @old.registration_type_page.submit(choice: :carrier_dealer)
  @old.business_details_page.submit(
    company_name: "UT Sole Trader",
    postcode: "BS1 5AH",
    result: "HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH"
  )
  @email_address = generate_email
  @old.contact_details_page.submit(
    first_name: "Bob",
    last_name: "Debuilder",
    phone_number: "0117 4960000",
    email: @email_address
  )
  @old.postal_address_page.submit

  people = @old.key_people_page.key_people
  @old.key_people_page.submit_key_person(person: people[0])

  @old.relevant_convictions_page.submit(choice: :no)
  @old.check_details_page.submit
  @old.sign_up_page.submit(
    registration_password: ENV["WCRS_DEFAULT_PASSWORD"],
    confirm_password: ENV["WCRS_DEFAULT_PASSWORD"],
    confirm_email: @email_address
  )
end

When(/^I complete my application of my charity as a lower tier waste carrier$/) do
  @old = OldApp.new
  @journey = JourneyApp.new
  @business_name = "LT charity"

  @old.old_start_page.load
  @old.old_start_page.submit
  expect(@journey.location_page.heading).to have_text("Where is your principal place of business?")
  @journey.location_page.submit(choice: :england)
  @old.old_business_type_page.submit(org_type: "charity")
  @old.business_details_page.submit(
    company_name: @business_name,
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
  @old.check_details_page.submit

  @old.sign_up_page.submit(
    registration_password: ENV["WCRS_DEFAULT_PASSWORD"],
    confirm_password: ENV["WCRS_DEFAULT_PASSWORD"],
    confirm_email: @email_address
  )
end

Given(/^I complete my application of my limited company "([^"]*)" as a lower tier waste carrier$/) do |company_name|
  @old = OldApp.new
  @journey = JourneyApp.new
  @old.old_start_page.load
  @old.old_start_page.submit
  expect(@journey.location_page.heading).to have_text("Where is your principal place of business?")
  @journey.location_page.submit(choice: :england)
  @old.old_business_type_page.submit(org_type: "limitedCompany")
  @old.other_businesses_question_page.submit(choice: :no)
  @old.construction_waste_question_page.submit(choice: :no)
  @old.business_details_page.submit(
    company_name: company_name,
    postcode: "BS1 5AH",
    result: "HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH"
  )
  @business_name = company_name
  @email_address = generate_email
  @old.contact_details_page.submit(
    first_name: "Bob",
    last_name: "Carolgees",
    phone_number: "0117 4960000",
    email: @email_address
  )
  @old.postal_address_page.submit
  @old.check_details_page.submit

  @old.sign_up_page.submit(
    registration_password: ENV["WCRS_DEFAULT_PASSWORD"],
    confirm_password: ENV["WCRS_DEFAULT_PASSWORD"],
    confirm_email: @email_address
  )
end

Then(/^I will be registered as a lower tier waste carrier$/) do
  expect(@old.old_confirmation_page.registration_number).to have_text("CBDL")
  expect(@old.old_confirmation_page).to have_text @email_address
  # Stores registration number for later use
  @reg_number = @old.old_confirmation_page.registration_number.text

  puts "Lower tier registration " + @reg_number + " completed"
end

When(/^I select that I don't know what business type to enter$/) do
  @old.old_business_type_page.submit(org_type: "other")
end

Then(/^I will be informed to contact the Environment Agency$/) do
  expect(page).to have_text "Contact the Environment Agency"
end

Given(/^I have signed in as "([^"]*)"$/) do |username|
  @old = OldApp.new
  @journey = JourneyApp.new
  @old.frontend_sign_in_page.load
  @old.frontend_sign_in_page.submit(
    email: username,
    password: ENV["WCRS_DEFAULT_PASSWORD"]
  )
end

When(/^I confirm my email address$/) do
  visit(Quke::Quke.config.custom["urls"]["last_email_fe"])
  confirmation_email_text = retrieve_email_containing([@email_address]).to_s
  expect(confirmation_email_text).to have_text("The next step is for you to confirm your email address")

  # Get the confirmation email link from the email text:
  # rubocop:disable Style/RedundantRegexpEscape
  confirmation_email_link = confirmation_email_text.match(/.*href\=\\"(.*)\\">http.*/)[1].to_s
  # rubocop:enable Style/RedundantRegexpEscape
  visit(confirmation_email_link)
end

Given(/^I do not confirm my email address$/) do
  # Nothing to do to replicate step
end
# rubocop:enable Metrics/BlockLength
