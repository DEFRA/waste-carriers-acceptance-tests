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

When(/^I complete my application of my local authority as a lower tier waste carrier$/) do
  @old = OldApp.new
  @journey = JourneyApp.new
  @old.old_start_page.load
  @old.old_start_page.submit
  expect(@journey.location_page.heading).to have_text("Where is your principal place of business?")
  @journey.location_page.submit(choice: :england)
  @old.old_business_type_page.submit(org_type: "authority")
  @old.business_details_page.submit(
    company_name: "LT local authority",
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

When(/^I complete my application of my partnership as a lower tier waste carrier$/) do
  @old = OldApp.new
  @journey = JourneyApp.new
  @old.old_start_page.load
  @old.old_start_page.submit
  expect(@journey.location_page.heading).to have_text("Where is your principal place of business?")
  @journey.location_page.submit(choice: :england)
  @old.old_business_type_page.submit(org_type: "partnership")
  @old.other_businesses_question_page.submit(choice: :yes)
  @old.service_provided_question_page.submit(choice: :not_main_service)
  @old.construction_waste_question_page.submit(choice: :no)
  @old.business_details_page.submit(
    company_name: "LT partnership",
    postcode: "BS1 5AH",
    result: "HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH"
  )
  @email_address = generate_email
  @old.contact_details_page.submit(
    first_name: "Terry",
    last_name: "Griffiths",
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

When(/^I complete my application of my public body as a lower tier waste carrier$/) do
  @old = OldApp.new
  @journey = JourneyApp.new
  @old.old_start_page.load
  @old.old_start_page.submit
  @old.old_business_type_page.submit(org_type: "publicBody")
  @old.other_businesses_question_page.submit(choice: :no)
  @old.construction_waste_question_page.submit(choice: :no)
  @old.business_details_page.submit(
    company_name: "LT public body",
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

Given(/^I complete my application of a sole trader business as a lower tier waste carrier$/) do
  @old = OldApp.new
  @journey = JourneyApp.new
  @old.old_start_page.load
  @old.old_start_page.submit
  expect(@journey.location_page.heading).to have_text("Where is your principal place of business?")
  @journey.location_page.submit(choice: :england)
  @old.old_business_type_page.submit(org_type: "soleTrader")
  @old.other_businesses_question_page.submit(choice: :yes)
  @old.service_provided_question_page.submit(choice: :not_main_service)
  @old.construction_waste_question_page.submit(choice: :no)
  @old.business_details_page.submit(
    company_name: "LT Sole Trader",
    postcode: "BS1 5AH",
    result: "HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH"
  )
  @email_address = generate_email
  @old.contact_details_page.submit(
    first_name: "Terry",
    last_name: "Griffiths",
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
