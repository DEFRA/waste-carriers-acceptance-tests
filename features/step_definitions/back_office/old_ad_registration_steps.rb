Given(/^an Environment Agency user has signed in to the backend$/) do
  Capybara.reset_session!
  load_all_apps
  @old.agency_sign_in_page.load
  @old.agency_sign_in_page.submit(
    email: Quke::Quke.config.custom["accounts"]["agency-user"]["username"],
    password: ENV["WCRS_DEFAULT_PASSWORD"]
  )
end

When(/^I have my registration of my charity as a lower tier waste carrier completed for me$/) do
  @old.old_business_type_page.submit(org_type: "charity")
  @old.business_details_page.submit(
    company_name: "AD LT Charity",
    postcode: "BS1 5AH",
    result: "HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH"
  )
  @old.contact_details_page.submit(
    first_name: "Bob",
    last_name: "Carolgees",
    phone_number: "0117 4960000"
  )
  @old.postal_address_page.submit
  @old.check_details_page.submit
end

When(/^I have my registration of my local authority as a lower tier waste carrier completed for me$/) do
  @old.old_business_type_page.submit(org_type: "authority")
  @old.business_details_page.submit(
    company_name: "AD LT Local Authority",
    postcode: "BS1 5AH",
    result: "HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH"
  )
  @old.contact_details_page.submit(
    first_name: "Bob",
    last_name: "Carolgees",
    phone_number: "0117 4960000"
  )
  @old.postal_address_page.submit
  @old.check_details_page.submit
end

Given(/^I have my registration of my limited company as a lower tier waste carrier completed for me$/) do
  @old.old_business_type_page.submit(org_type: "limitedCompany")
  @old.other_businesses_question_page.submit(choice: :yes)
  @old.service_provided_question_page.submit(choice: :main_service)
  @old.only_deal_with_question_page.submit(choice: :farm_waste)
  @old.business_details_page.submit(
    company_name: "AD LT Company limited",
    postcode: "BS1 5AH",
    result: "HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH"
  )
  @old.contact_details_page.submit(
    first_name: "Bob",
    last_name: "Carolgees",
    phone_number: "0117 4960000"
  )
  @old.postal_address_page.submit
  @old.check_details_page.submit
end

When(/^I have my registration of my partnership as a lower tier waste carrier completed for me$/) do
  @old.old_business_type_page.submit(org_type: "partnership")
  @old.other_businesses_question_page.submit(choice: :yes)
  @old.service_provided_question_page.submit(choice: :not_main_service)
  @old.construction_waste_question_page.submit(choice: :no)
  @old.business_details_page.submit(
    company_name: "AD LT Partnership",
    postcode: "BS1 5AH",
    result: "HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH"
  )
  @old.contact_details_page.submit(
    first_name: "Bob",
    last_name: "Carolgees",
    phone_number: "0117 4960000"
  )
  @old.postal_address_page.submit
  @old.check_details_page.submit
end

When(/^I have my registration of my public body as a lower tier waste carrier completed for me$/) do
  @old.old_business_type_page.submit(org_type: "publicBody")
  @old.other_businesses_question_page.submit(choice: :yes)
  @old.service_provided_question_page.submit(choice: :main_service)
  @old.only_deal_with_question_page.submit(choice: :farm_waste)
  @old.business_details_page.submit(
    company_name: "AD LT Public Body",
    postcode: "BS1 5AH",
    result: "HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH"
  )
  @old.contact_details_page.submit(
    first_name: "Bob",
    last_name: "Carolgees",
    phone_number: "0117 4960000"
  )
  @old.postal_address_page.submit
  @old.check_details_page.submit
end

When(/^I have my sole trader business lower tier waste carrier registration completed for me$/) do
  @old.old_business_type_page.submit(org_type: "soleTrader")
  @old.other_businesses_question_page.submit(choice: :no)
  @old.construction_waste_question_page.submit(choice: :no)
  @old.business_details_page.submit(
    company_name: "AD LT Sole Trader",
    postcode: "BS1 5AH",
    result: "HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH"
  )

  @old.contact_details_page.submit(
    first_name: "Terry",
    last_name: "Griffiths",
    phone_number: "0117 4960000"
  )
  @old.postal_address_page.submit
  @old.check_details_page.submit
end

When(/^the applicant chooses to pay for the registration by bank transfer ordering (\d+) copy (?:card|cards)$/) do |copy_card_number|
  @old.old_order_page.submit(
    copy_card_number: copy_card_number,
    choice: :bank_transfer_payment
  )
  @old.offline_payment_page.submit

  # Show "Registration pending" page
  expect(@old.finish_assisted_page).to have_text("Registration pending")
  expect(@old.finish_assisted_page.registration_number).to have_text("CBDU")

  @reg_number = @old.finish_assisted_page.registration_number.text
  puts "Registration " + @reg_number + " submitted by bank transfer with " + copy_card_number.to_s + " card(s)"
  @reg_balance = 154 + copy_card_number * 5

end

When(/^I pay for my application over the phone by maestro ordering (\d+) copy (?:card|cards)$/) do |copy_card_number|
  @old.old_order_page.submit(
    copy_card_number: copy_card_number,
    choice: :card_payment
  )
  submit_valid_card_payment
end

When(/^I have my limited company upper tier registration completed for me on backend$/) do
  @old.old_business_type_page.submit(org_type: "limitedCompany")
  @old.other_businesses_question_page.submit(choice: :no)
  @old.construction_waste_question_page.submit(choice: :yes)
  @old.registration_type_page.submit(choice: :carrier_broker_dealer)
  @old.business_details_page.submit(
    companies_house_number: "00445790",
    company_name: "AD UT Company limited",
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
end

When(/^I have my partnership upper tier regstration completed for me on backend$/) do
  @old.old_business_type_page.submit(org_type: "partnership")
  @old.other_businesses_question_page.submit(choice: :yes)
  @old.service_provided_question_page.submit(choice: :main_service)
  @old.only_deal_with_question_page.submit(choice: :not_farm_waste)
  @old.registration_type_page.submit(choice: :broker_dealer)
  @old.business_details_page.submit(
    company_name: "AD Upper Tier Partnership",
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
end

When(/^I have my public body upper tier registration completed for me on backend$/) do
  @old.old_business_type_page.submit(org_type: "publicBody")
  @old.other_businesses_question_page.submit(choice: :no)
  @old.construction_waste_question_page.submit(choice: :yes)
  @old.registration_type_page.submit(choice: :broker_dealer)
  @old.business_details_page.submit(
    company_name: "AD UT Public Body",
    postcode: "BS1 5AH",
    result: "HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH"
  )
  @old.contact_details_page.submit(
    first_name: "Bob",
    last_name: "Debuilder",
    phone_number: "0117 4960000"
  )
  @old.postal_address_page.submit

  people = @old.key_people_page.key_people
  @old.key_people_page.submit_key_person(person: people[0])

  @old.relevant_convictions_page.submit(choice: :no)
  @old.check_details_page.submit
end

Given(/^I request assistance with a new registration$/) do
  visit(Quke::Quke.config.custom["urls"]["back_end_registrations"])
  @old.old_start_page.submit
  expect(@journey.location_page.heading).to have_text("Where is your principal place of business?")
  @journey.location_page.submit(choice: :england)
end

Then(/^I will have an upper tier registration$/) do
  expect(@old.finish_assisted_page.registration_number).to have_text("CBDU")
  expect(@old.finish_assisted_page).to have_view_certificate

  # Stores registration number and access code for later use
  @reg_number = @old.finish_assisted_page.registration_number.text
  puts @reg_number + " upper tier registration completed on old app"
end

Then(/^(?:the|my) registration status will be "([^"]*)"$/) do |status|
  # resets session cookies to fix back office authentication issue
  # Warning! This test will fail (and keep refreshing the page) if @reg_number matches a previously seeded registration.
  # This is a known issue which affects test.
  # Resetting data will fix this.
  Capybara.reset_session!
  @old = OldApp.new
  @bo = BackOfficeApp.new
  @old.agency_sign_in_page.load
  @old.agency_sign_in_page.submit(
    email: Quke::Quke.config.custom["accounts"]["agency-user"]["username"],
    password: ENV["WCRS_DEFAULT_PASSWORD"]
  )
  @old.backend_registrations_page.search(search_input: @reg_number)
  @old.backend_registrations_page.wait_for_status(status)
  expect(@old.backend_registrations_page.search_results[0].status.text).to eq(status)
end
