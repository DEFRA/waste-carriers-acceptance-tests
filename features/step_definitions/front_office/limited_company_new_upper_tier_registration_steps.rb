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

When(/^I complete my application of my limited company as an upper tier waste carrier using my email "([^"]*)"$/) do |email_address|
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
  @email_address = email_address
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

  @old.registration_sign_in_page.submit(
    password: ENV["WCRS_DEFAULT_PASSWORD"],
    email: @email_address
  )
end

Given(/^(?:my|a) limited company with companies house number "([^"]*)" registers as an upper tier waste carrier$/) do |no|
  @old = OldApp.new
  @journey = JourneyApp.new
  @old.old_start_page.load
  @old.old_start_page.submit
  expect(@journey.location_page.heading).to have_text("Where is your principal place of business?")
  @journey.location_page.submit(choice: :england)
  @journey.confirm_business_type_page.submit(org_type: "limitedCompany")
  @old.other_businesses_question_page.submit(choice: :no)
  @old.construction_waste_question_page.submit(choice: :yes)
  @old.registration_type_page.submit(choice: :carrier_broker_dealer)
  @old.business_details_page.submit(
    companies_house_number: no,
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
  @old.old_order_page.submit(
    copy_card_number: "2",
    choice: :card_payment
  )

  submit_valid_card_payment

  expect(@old.old_confirmation_page.registration_number).to have_text("CBDU")
  expect(@old.old_confirmation_page).to have_text @email_address
  # Stores registration number for later use
  @reg_number = @old.old_confirmation_page.registration_number.text
  puts "Upper tier registration " + @reg_number + " completed by a limited company"
end
