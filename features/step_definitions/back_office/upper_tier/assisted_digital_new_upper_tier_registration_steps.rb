When(/^I have my sole trader upper tier waste carrier application completed for me$/) do
  @back_app.business_type_page.submit(org_type: "soleTrader")
  old_select_upper_tier_options("carrier_broker_dealer")
  @back_app.business_details_page.submit(
    company_name: "AD UT Sole Trader",
    postcode: "BS1 5AH",
    result: "HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH"
  )
  @back_app.contact_details_page.submit(
    first_name: "Bob",
    last_name: "Debuilder",
    phone_number: "0117 4960000"
  )
  @back_app.postal_address_page.submit

  people = @back_app.key_people_page.key_people
  @back_app.key_people_page.submit_key_person(person: people[0])

  @back_app.relevant_convictions_page.submit(choice: :no)
  @back_app.check_details_page.submit
end

When(/^I have my limited company as a upper tier waste carrier application completed for me$/) do
  @back_app.business_type_page.submit(org_type: "limitedCompany")
  @back_app.other_businesses_question_page.submit(choice: :no)
  @back_app.construction_waste_question_page.submit(choice: :yes)
  @back_app.registration_type_page.submit(choice: :carrier_broker_dealer)
  @back_app.business_details_page.submit(
    companies_house_number: "00445790",
    company_name: "AD UT Company limited",
    postcode: "BS1 5AH",
    result: "HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH"
  )
  @back_app.contact_details_page.submit(
    first_name: "Bob",
    last_name: "Carolgees",
    phone_number: "0117 4960000"
  )
  @back_app.postal_address_page.submit

  people = @back_app.key_people_page.key_people

  @back_app.key_people_page.add_key_person(person: people[0])
  @back_app.key_people_page.add_key_person(person: people[1])
  @back_app.key_people_page.submit_key_person(person: people[2])

  @back_app.relevant_convictions_page.submit(choice: :no)
  @back_app.check_details_page.submit
end

When(/^I have my partnership upper tier waste carrier application completed for me$/) do
  @back_app.business_type_page.submit(org_type: "partnership")
  @back_app.other_businesses_question_page.submit(choice: :yes)
  @back_app.service_provided_question_page.submit(choice: :main_service)
  @back_app.only_deal_with_question_page.submit(choice: :not_farm_waste)
  @back_app.registration_type_page.submit(choice: :broker_dealer)
  @back_app.business_details_page.submit(
    company_name: "AD Upper Tier Partnership",
    postcode: "BS1 5AH",
    result: "HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH"
  )
  @back_app.contact_details_page.submit(
    first_name: "Bob",
    last_name: "Carolgees",
    phone_number: "0117 4960000"
  )
  @back_app.postal_address_page.submit

  people = @back_app.key_people_page.key_people

  @back_app.key_people_page.add_key_person(person: people[0])
  @back_app.key_people_page.add_key_person(person: people[1])
  @back_app.key_people_page.submit_key_person(person: people[2])

  @back_app.relevant_convictions_page.submit(choice: :no)
  @back_app.check_details_page.submit
end

When(/^I have my public body upper tier waste carrier application completed for me$/) do
  @back_app.business_type_page.submit(org_type: "publicBody")
  @back_app.other_businesses_question_page.submit(choice: :no)
  @back_app.construction_waste_question_page.submit(choice: :yes)
  @back_app.registration_type_page.submit(choice: :broker_dealer)
  @back_app.business_details_page.submit(
    company_name: "AD UT Public Body",
    postcode: "BS1 5AH",
    result: "HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH"
  )
  @back_app.contact_details_page.submit(
    first_name: "Bob",
    last_name: "Debuilder",
    phone_number: "0117 4960000"
  )
  @back_app.postal_address_page.submit

  people = @back_app.key_people_page.key_people
  @back_app.key_people_page.submit_key_person(person: people[0])

  @back_app.relevant_convictions_page.submit(choice: :no)
  @back_app.check_details_page.submit
end

Given(/^(?:a|my) limited company "([^"]*)" registers as an upper tier waste carrier$/) do |co_name|
  @business_name = co_name
  @back_app.registrations_page.new_registration.click
  @back_app.old_start_page.submit
  expect(@journey.location_page.heading).to have_text("Where is your principal place of business?")
  @journey.location_page.submit(choice: :england)
  @back_app.business_type_page.submit(org_type: "limitedCompany")
  old_select_upper_tier_options("carrier_broker_dealer")
  @back_app.business_details_page.submit(
    companies_house_number: "00445790",
    company_name: co_name,
    postcode: "BS1 5AH",
    result: "HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH"
  )
  @back_app.contact_details_page.submit(
    first_name: "Bob",
    last_name: "Carolgees",
    phone_number: "0117 4960000"
  )
  @back_app.postal_address_page.submit

  people = @back_app.key_people_page.key_people

  @back_app.key_people_page.add_key_person(person: people[0])
  @back_app.key_people_page.add_key_person(person: people[1])
  @back_app.key_people_page.submit_key_person(person: people[2])

  @back_app.relevant_convictions_page.submit(choice: :no)
  @back_app.check_details_page.submit
  @back_app.order_page.submit(
    copy_card_number: 2,
    choice: :card_payment
  )

  submit_valid_card_payment

  @reg_number = @back_app.finish_assisted_page.registration_number.text
  @back_app.agency_sign_in_page.load
end

Given(/a key person with a conviction registers as a sole trader upper tier waste carrier$/) do

  @business_name = "AD UT Sole Trader"
  @back_app.registrations_page.new_registration.click
  @back_app.old_start_page.submit
  expect(@journey.location_page.heading).to have_text("Where is your principal place of business?")
  @journey.location_page.submit(choice: :england)
  @back_app.business_type_page.submit(org_type: "soleTrader")
  old_select_upper_tier_options("carrier_broker_dealer")
  @back_app.business_details_page.submit(
    company_name: @business_name,
    postcode: "BS1 5AH",
    result: "HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH"
  )
  @back_app.contact_details_page.submit(
    first_name: "Bob",
    last_name: "Debuilder",
    phone_number: "0117 4960000"
  )
  @back_app.postal_address_page.submit

  people = @back_app.key_people_page.dodgy_people
  @back_app.key_people_page.submit_key_person(person: people[2])

  @back_app.relevant_convictions_page.submit(choice: :no)
  @back_app.check_details_page.submit
  @back_app.order_page.submit(
    copy_card_number: 2,
    choice: :card_payment
  )

  submit_valid_card_payment

  @reg_number = @back_app.finish_assisted_page.registration_number.text
end

Given(/^a conviction is declared when registering their partnership for an upper tier waste carrier$/) do
  @business_name = "AD Upper Tier Partnership"
  @back_app.registrations_page.new_registration.click
  @back_app.old_start_page.submit
  expect(@journey.location_page.heading).to have_text("Where is your principal place of business?")
  @journey.location_page.submit(choice: :england)
  @back_app.business_type_page.submit(org_type: "partnership")
  old_select_upper_tier_options("carrier_broker_dealer")
  @back_app.business_details_page.submit(
    company_name: @business_name,
    postcode: "BS1 5AH",
    result: "HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH"
  )
  @back_app.contact_details_page.submit(
    first_name: "Bob",
    last_name: "Carolgees",
    phone_number: "0117 4960000"
  )
  @back_app.postal_address_page.submit

  people = @back_app.key_people_page.key_people

  @back_app.key_people_page.add_key_person(person: people[0])
  @back_app.key_people_page.add_key_person(person: people[1])
  @back_app.key_people_page.submit_key_person(person: people[2])

  old_submit_convictions("convictions")
  @back_app.check_details_page.submit
  @back_app.order_page.submit(
    copy_card_number: 2,
    choice: :card_payment
  )

  submit_valid_card_payment

  @reg_number = @back_app.finish_assisted_page.registration_number.text
end
