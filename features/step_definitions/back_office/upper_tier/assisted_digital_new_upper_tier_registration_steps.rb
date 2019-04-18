When(/^I have my sole trader upper tier waste carrier application completed for me$/) do
  @back_app.business_type_page.submit(org_type: "soleTrader")
  @back_app.other_businesses_question_page.submit(choice: :yes)
  @back_app.service_provided_question_page.submit(choice: :not_main_service)
  @back_app.construction_waste_question_page.submit(choice: :yes)
  @back_app.registration_type_page.submit(choice: :carrier_broker_dealer)
  @back_app.business_details_page.submit(
    company_name: "AD UT Sole Trader",
    postcode: "BS1 5AH",
    result: "ENVIRONMENT AGENCY, HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH"
  )
  @back_app.contact_details_page.submit(
    first_name: "Bob",
    last_name: "Debuilder",
    phone_number: "012345678"
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
    result: "ENVIRONMENT AGENCY, HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH"
  )
  @back_app.contact_details_page.submit(
    first_name: "Bob",
    last_name: "Carolgees",
    phone_number: "012345678"
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
    result: "ENVIRONMENT AGENCY, HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH"
  )
  @back_app.contact_details_page.submit(
    first_name: "Bob",
    last_name: "Carolgees",
    phone_number: "012345678"
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
    result: "ENVIRONMENT AGENCY, HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH"
  )
  @back_app.contact_details_page.submit(
    first_name: "Bob",
    last_name: "Debuilder",
    phone_number: "012345678"
  )
  @back_app.postal_address_page.submit

  people = @back_app.key_people_page.key_people
  @back_app.key_people_page.submit_key_person(person: people[0])

  @back_app.relevant_convictions_page.submit(choice: :no)
  @back_app.check_details_page.submit
end
# rubocop:disable Metrics/LineLength
Given(/^a limited company with companies house number "([^"]*)" is registered as an upper tier waste carrier$/) do |ch_no|
  @back_app.registrations_page.new_registration.click
  @back_app.start_page.submit
  @back_app.business_type_page.submit(org_type: "limitedCompany")
  @back_app.other_businesses_question_page.submit(choice: :no)
  @back_app.construction_waste_question_page.submit(choice: :yes)
  @back_app.registration_type_page.submit(choice: :carrier_broker_dealer)
  @back_app.business_details_page.submit(
    companies_house_number: ch_no,
    company_name: "AD UT Company convictions check ltd",
    postcode: "BS1 5AH",
    result: "ENVIRONMENT AGENCY, HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH"
  )
  # Stores companies house number for later
  @companies_house_number = ch_no
  @back_app.contact_details_page.submit(
    first_name: "Bob",
    last_name: "Carolgees",
    phone_number: "012345678"
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
  click(@back_app.worldpay_card_choice_page.maestro)

  # finds today's date and adds another year to expiry date
  time = Time.new

  @year = time.year + 1

  @back_app.worldpay_card_details_page.submit(
    card_number: "6759649826438453",
    security_code: "555",
    cardholder_name: "3d.authorised",
    expiry_month: "12",
    expiry_year: @year
  )
  @registration_number = @back_app.finish_assisted_page.registration_number.text
end
# rubocop:enable Metrics/LineLength

Given(/^(?:a|my) limited company "([^"]*)" registers as an upper tier waste carrier$/) do |co_name|
  @back_app.registrations_page.new_registration.click
  @back_app.start_page.submit
  @back_app.business_type_page.submit(org_type: "limitedCompany")
  @back_app.other_businesses_question_page.submit(choice: :no)
  @back_app.construction_waste_question_page.submit(choice: :yes)
  @back_app.registration_type_page.submit(choice: :carrier_broker_dealer)
  @back_app.business_details_page.submit(
    companies_house_number: "00445790",
    company_name: co_name,
    postcode: "BS1 5AH",
    result: "ENVIRONMENT AGENCY, HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH"
  )
  @back_app.contact_details_page.submit(
    first_name: "Bob",
    last_name: "Carolgees",
    phone_number: "012345678"
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
  click(@back_app.worldpay_card_choice_page.maestro)

  # finds today's date and adds another year to expiry date
  time = Time.new

  @year = time.year + 1

  @back_app.worldpay_card_details_page.submit(
    card_number: "6759649826438453",
    security_code: "555",
    cardholder_name: "3d.authorised",
    expiry_month: "12",
    expiry_year: @year
  )
  @registration_number = @back_app.finish_assisted_page.registration_number.text
  @back_app.agency_sign_in_page.load
end

Given(/a key person with a conviction registers as a sole trader upper tier waste carrier$/) do
  @back_app.registrations_page.new_registration.click
  @back_app.start_page.submit
  @back_app.business_type_page.submit(org_type: "soleTrader")
  @back_app.other_businesses_question_page.submit(choice: :yes)
  @back_app.service_provided_question_page.submit(choice: :not_main_service)
  @back_app.construction_waste_question_page.submit(choice: :yes)
  @back_app.registration_type_page.submit(choice: :carrier_broker_dealer)
  @back_app.business_details_page.submit(
    company_name: "AD UT Sole Trader",
    postcode: "BS1 5AH",
    result: "ENVIRONMENT AGENCY, HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH"
  )
  @back_app.contact_details_page.submit(
    first_name: "Bob",
    last_name: "Debuilder",
    phone_number: "012345678"
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
  click(@back_app.worldpay_card_choice_page.maestro)

  # finds today's date and adds another year to expiry date
  time = Time.new

  @year = time.year + 1

  @back_app.worldpay_card_details_page.submit(
    card_number: "6759649826438453",
    security_code: "555",
    cardholder_name: "3d.authorised",
    expiry_month: "12",
    expiry_year: @year
  )
  @registration_number = @back_app.finish_assisted_page.registration_number.text
end

Given(/^a conviction is declared when registering their partnership for an upper tier waste carrier$/) do
  @back_app.registrations_page.new_registration.click
  @back_app.start_page.submit
  @back_app.business_type_page.submit(org_type: "partnership")
  @back_app.other_businesses_question_page.submit(choice: :yes)
  @back_app.service_provided_question_page.submit(choice: :main_service)
  @back_app.only_deal_with_question_page.submit(choice: :not_farm_waste)
  @back_app.registration_type_page.submit(choice: :broker_dealer)
  @back_app.business_details_page.submit(
    company_name: "AD Upper Tier Partnership",
    postcode: "BS1 5AH",
    result: "ENVIRONMENT AGENCY, HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH"
  )
  @back_app.contact_details_page.submit(
    first_name: "Bob",
    last_name: "Carolgees",
    phone_number: "012345678"
  )
  @back_app.postal_address_page.submit

  people = @back_app.key_people_page.key_people

  @back_app.key_people_page.add_key_person(person: people[0])
  @back_app.key_people_page.add_key_person(person: people[1])
  @back_app.key_people_page.submit_key_person(person: people[2])

  @back_app.relevant_convictions_page.submit(choice: :yes)
  people = @back_app.relevant_people_page.relevant_people
  @back_app.relevant_people_page.submit_relevant_person(person: people[0])
  @back_app.check_details_page.submit
  @back_app.order_page.submit(
    copy_card_number: 2,
    choice: :card_payment
  )
  click(@back_app.worldpay_card_choice_page.maestro)

  # finds today's date and adds another year to expiry date
  time = Time.new

  @year = time.year + 1

  @back_app.worldpay_card_details_page.submit(
    card_number: "6759649826438453",
    security_code: "555",
    cardholder_name: "3d.authorised",
    expiry_month: "12",
    expiry_year: @year
  )
  @registration_number = @back_app.finish_assisted_page.registration_number.text
end
