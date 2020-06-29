When(/^I complete my application of my charity as a lower tier waste carrier$/) do
  @front_app = FrontOfficeApp.new
  @journey = JourneyApp.new
  @business_name = "LT charity"

  @front_app.old_start_page.load
  @front_app.old_start_page.submit
  expect(@journey.location_page.heading).to have_text("Where is your principal place of business?")
  @journey.location_page.submit(choice: :england)
  @front_app.business_type_page.submit(org_type: "charity")
  @front_app.business_details_page.submit(
    company_name: @business_name,
    postcode: "BS1 5AH",
    result: "HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH"
  )
  @email_address = generate_email
  @front_app.contact_details_page.submit(
    first_name: "Bob",
    last_name: "Carolgees",
    phone_number: "0117 4960000",
    email: @email_address
  )
  @front_app.postal_address_page.submit
  @front_app.check_details_page.submit

  @front_app.sign_up_page.submit(
    registration_password: ENV["WCRS_DEFAULT_PASSWORD"],
    confirm_password: ENV["WCRS_DEFAULT_PASSWORD"],
    confirm_email: @email_address
  )
end

When(/^I complete my application of my local authority as a lower tier waste carrier$/) do
  @front_app = FrontOfficeApp.new
  @journey = JourneyApp.new
  @front_app.old_start_page.load
  @front_app.old_start_page.submit
  expect(@journey.location_page.heading).to have_text("Where is your principal place of business?")
  @journey.location_page.submit(choice: :england)
  @front_app.business_type_page.submit(org_type: "authority")
  @front_app.business_details_page.submit(
    company_name: "LT local authority",
    postcode: "BS1 5AH",
    result: "HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH"
  )
  @email_address = generate_email
  @front_app.contact_details_page.submit(
    first_name: "Bob",
    last_name: "Carolgees",
    phone_number: "0117 4960000",
    email: @email_address
  )
  @front_app.postal_address_page.submit
  @front_app.check_details_page.submit

  @front_app.sign_up_page.submit(
    registration_password: ENV["WCRS_DEFAULT_PASSWORD"],
    confirm_password: ENV["WCRS_DEFAULT_PASSWORD"],
    confirm_email: @email_address
  )
end

When(/^I complete my application of my partnership as a lower tier waste carrier$/) do
  @front_app = FrontOfficeApp.new
  @journey = JourneyApp.new
  @front_app.old_start_page.load
  @front_app.old_start_page.submit
  expect(@journey.location_page.heading).to have_text("Where is your principal place of business?")
  @journey.location_page.submit(choice: :england)
  @front_app.business_type_page.submit(org_type: "partnership")
  @front_app.other_businesses_question_page.submit(choice: :yes)
  @front_app.service_provided_question_page.submit(choice: :not_main_service)
  @front_app.construction_waste_question_page.submit(choice: :no)
  @front_app.business_details_page.submit(
    company_name: "LT partnership",
    postcode: "BS1 5AH",
    result: "HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH"
  )
  @email_address = generate_email
  @front_app.contact_details_page.submit(
    first_name: "Terry",
    last_name: "Griffiths",
    phone_number: "0117 4960000",
    email: @email_address
  )
  @front_app.postal_address_page.submit
  @front_app.check_details_page.submit

  @front_app.sign_up_page.submit(
    registration_password: ENV["WCRS_DEFAULT_PASSWORD"],
    confirm_password: ENV["WCRS_DEFAULT_PASSWORD"],
    confirm_email: @email_address
  )
end

When(/^I complete my application of my public body as a lower tier waste carrier$/) do
  @front_app = FrontOfficeApp.new
  @journey = JourneyApp.new
  @front_app.old_start_page.load
  @front_app.old_start_page.submit
  @front_app.business_type_page.submit(org_type: "publicBody")
  @front_app.other_businesses_question_page.submit(choice: :no)
  @front_app.construction_waste_question_page.submit(choice: :no)
  @front_app.business_details_page.submit(
    company_name: "LT public body",
    postcode: "BS1 5AH",
    result: "HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH"
  )
  @email_address = generate_email
  @front_app.contact_details_page.submit(
    first_name: "Bob",
    last_name: "Carolgees",
    phone_number: "0117 4960000",
    email: @email_address
  )
  @front_app.postal_address_page.submit
  @front_app.check_details_page.submit

  @front_app.sign_up_page.submit(
    registration_password: ENV["WCRS_DEFAULT_PASSWORD"],
    confirm_password: ENV["WCRS_DEFAULT_PASSWORD"],
    confirm_email: @email_address
  )
end

Given(/^I complete my application of a sole trader business as a lower tier waste carrier$/) do
  @front_app = FrontOfficeApp.new
  @journey = JourneyApp.new
  @front_app.old_start_page.load
  @front_app.old_start_page.submit
  expect(@journey.location_page.heading).to have_text("Where is your principal place of business?")
  @journey.location_page.submit(choice: :england)
  @front_app.business_type_page.submit(org_type: "soleTrader")
  @front_app.other_businesses_question_page.submit(choice: :yes)
  @front_app.service_provided_question_page.submit(choice: :not_main_service)
  @front_app.construction_waste_question_page.submit(choice: :no)
  @front_app.business_details_page.submit(
    company_name: "LT Sole Trader",
    postcode: "BS1 5AH",
    result: "HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH"
  )
  @email_address = generate_email
  @front_app.contact_details_page.submit(
    first_name: "Terry",
    last_name: "Griffiths",
    phone_number: "0117 4960000",
    email: @email_address
  )
  @front_app.postal_address_page.submit
  @front_app.check_details_page.submit

  @front_app.sign_up_page.submit(
    registration_password: ENV["WCRS_DEFAULT_PASSWORD"],
    confirm_password: ENV["WCRS_DEFAULT_PASSWORD"],
    confirm_email: @email_address
  )
end

Given(/^I complete my application of my limited company "([^"]*)" as a lower tier waste carrier$/) do |company_name|
  @front_app = FrontOfficeApp.new
  @journey = JourneyApp.new
  @front_app.old_start_page.load
  @front_app.old_start_page.submit
  expect(@journey.location_page.heading).to have_text("Where is your principal place of business?")
  @journey.location_page.submit(choice: :england)
  @front_app.business_type_page.submit(org_type: "limitedCompany")
  @front_app.other_businesses_question_page.submit(choice: :no)
  @front_app.construction_waste_question_page.submit(choice: :no)
  @front_app.business_details_page.submit(
    company_name: company_name,
    postcode: "BS1 5AH",
    result: "HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH"
  )
  @business_name = company_name
  @email_address = generate_email
  @front_app.contact_details_page.submit(
    first_name: "Bob",
    last_name: "Carolgees",
    phone_number: "0117 4960000",
    email: @email_address
  )
  @front_app.postal_address_page.submit
  @front_app.check_details_page.submit

  @front_app.sign_up_page.submit(
    registration_password: ENV["WCRS_DEFAULT_PASSWORD"],
    confirm_password: ENV["WCRS_DEFAULT_PASSWORD"],
    confirm_email: @email_address
  )
end
