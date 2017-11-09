When(/^I complete my application of my limited company as an upper tier waste carrier$/) do
  @front_app.business_type_page.submit(org_type: "limitedCompany")
  @front_app.other_businesses_question_page.submit(choice: :no)
  @front_app.construction_waste_question_page.submit(choice: :yes)
  @front_app.registration_type_page.submit(choice: :carrier_broker_dealer)
  @front_app.business_details_page.submit(
    companies_house_number: "00233462",
    company_name: "UT Company limited",
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

  @front_app.key_people_page.add_key_person(person: people[0])
  @front_app.key_people_page.add_key_person(person: people[1])
  @front_app.key_people_page.submit_key_person(person: people[2])

  @front_app.relevant_convictions_page.submit(choice: :no)
  @front_app.declaration_page.submit
  @front_app.sign_up_page.submit(
    registration_password: "Secret123",
    confirm_password: "Secret123",
    confirm_email: @email
  )
end

When(/^I complete my aplication of my partnership as a upper tier waste carrier$/) do
  @front_app.business_type_page.submit(org_type: "partnership")
  @front_app.other_businesses_question_page.submit(choice: :yes)
  @front_app.service_provided_question_page.submit(choice: :main_service)
  @front_app.only_deal_with_question_page.submit(choice: :not_farm_waste)
  @front_app.registration_type_page.submit(choice: :broker_dealer)
  @front_app.business_details_page.submit(
    company_name: "UT Partnership",
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

  @front_app.key_people_page.add_key_person(person: people[0])
  @front_app.key_people_page.add_key_person(person: people[1])
  @front_app.key_people_page.submit_key_person(person: people[2])

  @front_app.relevant_convictions_page.submit(choice: :no)
  @front_app.declaration_page.submit
  @front_app.sign_up_page.submit(
    registration_password: "Secret123",
    confirm_password: "Secret123",
    confirm_email: @email
  )
end

When(/^I complete my application of my public body as an upper tier waste carrier$/) do
  @front_app.business_type_page.submit(org_type: "publicBody")
  @front_app.other_businesses_question_page.submit(choice: :yes)
  @front_app.service_provided_question_page.submit(choice: :not_main_service)
  @front_app.construction_waste_question_page.submit(choice: :yes)
  @front_app.registration_type_page.submit(choice: :carrier_broker_dealer)
  @front_app.business_details_page.submit(
    company_name: "UT Public Body",
    postcode: "BS1 5AH",
    result: "ENVIRONMENT AGENCY, HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH"
  )
  @email = @front_app.generate_email
  @front_app.contact_details_page.submit(
    first_name: "Bob",
    last_name: "Debuilder",
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
end

When(/^I complete my application of my sole trader business as a upper tier waste carrier$/) do
  @front_app.business_type_page.submit(org_type: "soleTrader")
  @front_app.other_businesses_question_page.submit(choice: :yes)
  @front_app.service_provided_question_page.submit(choice: :not_main_service)
  @front_app.construction_waste_question_page.submit(choice: :yes)
  @front_app.registration_type_page.submit(choice: :carrier_dealer)
  @front_app.business_details_page.submit(
    company_name: "UT Sole Trader",
    postcode: "BS1 5AH",
    result: "ENVIRONMENT AGENCY, HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH"
  )
  @email = @front_app.generate_email
  @front_app.contact_details_page.submit(
    first_name: "Bob",
    last_name: "Debuilder",
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
end

Given(/^I have registered my limited company as an upper tier "([^"]*)"$/) do |registration_type|
  @front_app = FrontOfficeApp.new
  @front_app.start_page.load
  @front_app.start_page.submit
  @front_app.business_type_page.submit(org_type: "limitedCompany")
  @front_app.other_businesses_question_page.submit(choice: :no)
  @front_app.construction_waste_question_page.submit(choice: :yes)
  @front_app.registration_type_page.submit(choice: registration_type.to_sym)
  @front_app.business_details_page.submit(
    companies_house_number: "00233462",
    company_name: "UT Company limited",
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

  @front_app.key_people_page.add_key_person(person: people[0])
  @front_app.key_people_page.add_key_person(person: people[1])
  @front_app.key_people_page.submit_key_person(person: people[2])

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
  expect(@front_app.registration_confirmed_page.registration_number).to have_text("CBDU")
  expect(@front_app.registration_confirmed_page).to have_text @email
  # Stores registration number for later use
  @registration_number = @front_app.registration_confirmed_page.registration_number.text
end

Given(/^I have registered my partnership as an upper tier waste carrier$/) do
  @front_app = FrontOfficeApp.new
  @front_app.start_page.load
  @front_app.start_page.submit
  @front_app.business_type_page.submit(org_type: "partnership")
  @front_app.other_businesses_question_page.submit(choice: :yes)
  @front_app.service_provided_question_page.submit(choice: :main_service)
  @front_app.only_deal_with_question_page.submit(choice: :not_farm_waste)
  @front_app.registration_type_page.submit(choice: :broker_dealer)
  @front_app.business_details_page.submit(
    company_name: "UT Partnership",
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

  @front_app.key_people_page.add_key_person(person: people[0])
  @front_app.key_people_page.add_key_person(person: people[1])
  @front_app.key_people_page.submit_key_person(person: people[2])

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

Given(/^I have registered my sole trading company as an uppper tier waste carrier$/) do
  @front_app = FrontOfficeApp.new
  @front_app.start_page.load
  @front_app.start_page.submit
  @front_app.business_type_page.submit(org_type: "soleTrader")
  @front_app.other_businesses_question_page.submit(choice: :yes)
  @front_app.service_provided_question_page.submit(choice: :not_main_service)
  @front_app.construction_waste_question_page.submit(choice: :yes)
  @front_app.registration_type_page.submit(choice: :carrier_dealer)
  @front_app.business_details_page.submit(
    company_name: "UT Sole Trader",
    postcode: "BS1 5AH",
    result: "ENVIRONMENT AGENCY, HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH"
  )
  @email = @front_app.generate_email
  @front_app.contact_details_page.submit(
    first_name: "Bob",
    last_name: "Debuilder",
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
