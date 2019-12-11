When(/^I complete my application of my limited company as an upper tier waste carrier$/) do
  @front_app.business_type_page.submit(org_type: "limitedCompany")
  @front_app.other_businesses_question_page.submit(choice: :no)
  @front_app.construction_waste_question_page.submit(choice: :yes)
  @front_app.registration_type_page.submit(choice: :carrier_broker_dealer)
  @front_app.business_details_page.submit(
    companies_house_number: "00445790",
    company_name: "UT Company limited",
    postcode: "BS1 5AH",
    result: "ENVIRONMENT AGENCY, HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH"
  )
  @email_address = generate_email
  @front_app.contact_details_page.submit(
    first_name: "Bob",
    last_name: "Carolgees",
    phone_number: "012345678",
    email: @email_address
  )
  @front_app.postal_address_page.submit

  people = @front_app.key_people_page.key_people

  @front_app.key_people_page.add_key_person(person: people[0])
  @front_app.key_people_page.add_key_person(person: people[1])
  @front_app.key_people_page.submit_key_person(person: people[2])

  @front_app.relevant_convictions_page.submit(choice: :no)
  @front_app.check_details_page.submit
  @front_app.sign_up_page.submit(
    registration_password: ENV["WCRS_DEFAULT_PASSWORD"],
    confirm_password: ENV["WCRS_DEFAULT_PASSWORD"],
    confirm_email: @email_address
  )
end

# rubocop:disable Metrics/LineLength
Given(/^(?:my|a) limited company with companies house number "([^"]*)" registers as an upper tier waste carrier$/) do |no|
  @front_app = FrontOfficeApp.new
  @journey = JourneyApp.new
  @front_app.start_page.load
  @front_app.start_page.submit
  expect(@front_app.location_page.heading).to have_text("Where is your principal place of business?")
  @front_app.location_page.submit(choice: :england)
  @front_app.business_type_page.submit(org_type: "limitedCompany")
  @front_app.other_businesses_question_page.submit(choice: :no)
  @front_app.construction_waste_question_page.submit(choice: :yes)
  @front_app.registration_type_page.submit(choice: :carrier_broker_dealer)
  @front_app.business_details_page.submit(
    companies_house_number: no,
    company_name: "UT Company limited",
    postcode: "BS1 5AH",
    result: "ENVIRONMENT AGENCY, HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH"
  )
  @email_address = generate_email
  @front_app.contact_details_page.submit(
    first_name: "Bob",
    last_name: "Carolgees",
    phone_number: "012345678",
    email: @email_address
  )
  @front_app.postal_address_page.submit

  people = @front_app.key_people_page.key_people

  @front_app.key_people_page.add_key_person(person: people[0])
  @front_app.key_people_page.add_key_person(person: people[1])
  @front_app.key_people_page.submit_key_person(person: people[2])

  @front_app.relevant_convictions_page.submit(choice: :no)
  @front_app.check_details_page.submit
  @front_app.sign_up_page.submit(
    registration_password: ENV["WCRS_DEFAULT_PASSWORD"],
    confirm_password: ENV["WCRS_DEFAULT_PASSWORD"],
    confirm_email: @email_address
  )
  @front_app.order_page.submit(
    copy_card_number: "2",
    choice: :card_payment
  )

  submit_valid_card_payment

  expect(@front_app.confirmation_page.registration_number).to have_text("CBDU")
  expect(@front_app.confirmation_page).to have_text @email_address
  # Stores registration number for later use
  @registration_number = @front_app.confirmation_page.registration_number.text
  puts "Upper tier registration " + @registration_number + " completed by a limited company"
end
# rubocop:enable Metrics/LineLength
