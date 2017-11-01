When(/^I complete my application of my charity as a lower tier waste carrier$/) do
  @app = FrontOfficeApp.new
  @app.start_page.load
  @app.start_page.submit
  @app.business_type_page.submit(org_type: "charity")
  @app.business_details_page.submit(
    company_name: "LT charity",
    postcode: "BS1 5AH",
    result: "ENVIRONMENT AGENCY, HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH"
  )
  @email = @app.generate_email
  @app.contact_details_page.submit(
    first_name: "Bob",
    last_name: "Carolgees",
    phone_number: "012345678",
    email: @email
  )
  @app.postal_address_page.submit
  @app.declaration_page.submit

  @app.sign_up_page.submit(
    registration_password: "Secret123",
    confirm_password: "Secret123",
    confirm_email: @email
  )
end

When(/^I complete my application of my local authority as a lower tier waste carrier$/) do
  @app = FrontOfficeApp.new
  @app.start_page.load
  @app.start_page.submit
  @app.business_type_page.submit(org_type: "authority")
  @app.business_details_page.submit(
    company_name: "LT local athority",
    postcode: "BS1 5AH",
    result: "ENVIRONMENT AGENCY, HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH"
  )
  @email = @app.generate_email
  @app.contact_details_page.submit(
    first_name: "Bob",
    last_name: "Carolgees",
    phone_number: "012345678",
    email: @email
  )
  @app.postal_address_page.submit
  @app.declaration_page.submit

  @app.sign_up_page.submit(
    registration_password: "Secret123",
    confirm_password: "Secret123",
    confirm_email: @email
  )
end

When(/^I complete my application of my partnership as a lower tier waste carrier$/) do
  @app = FrontOfficeApp.new
  @app.start_page.load
  @app.start_page.submit
  @app.business_type_page.submit(org_type: "partnership")
  @app.other_businesses_question_page.submit(choice: :yes)
  @app.service_provided_question_page.submit(choice: :not_main_service)
  @app.construction_waste_question_page.submit(choice: :no)
  @app.business_details_page.submit(
    company_name: "LT partnership",
    postcode: "BS1 5AH",
    result: "ENVIRONMENT AGENCY, HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH"
  )
  @email = @app.generate_email
  @app.contact_details_page.submit(
    first_name: "Terry",
    last_name: "Griffiths",
    phone_number: "012345678",
    email: @email
  )
  @app.postal_address_page.submit
  @app.declaration_page.submit

  @app.sign_up_page.submit(
    registration_password: "Secret123",
    confirm_password: "Secret123",
    confirm_email: @email
  )
end

When(/^I complete my application of my public body as a lower tier waste carrier$/) do
  @app = FrontOfficeApp.new
  @app.start_page.load
  @app.start_page.submit
  @app.business_type_page.submit(org_type: "publicBody")
  @app.other_businesses_question_page.submit(choice: :no)
  @app.construction_waste_question_page.submit(choice: :no)
  @app.business_details_page.submit(
    company_name: "LT public body",
    postcode: "BS1 5AH",
    result: "ENVIRONMENT AGENCY, HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH"
  )
  @email = @app.generate_email
  @app.contact_details_page.submit(
    first_name: "Bob",
    last_name: "Carolgees",
    phone_number: "012345678",
    email: @email
  )
  @app.postal_address_page.submit
  @app.declaration_page.submit

  @app.sign_up_page.submit(
    registration_password: "Secret123",
    confirm_password: "Secret123",
    confirm_email: @email
  )
end

Given(/^I complete my application of a sole trader business as a lower tier waste carrier$/) do
  @app = FrontOfficeApp.new
  @app.start_page.load
  @app.start_page.submit
  @app.business_type_page.submit(org_type: "soleTrader")
  @app.other_businesses_question_page.submit(choice: :yes)
  @app.service_provided_question_page.submit(choice: :not_main_service)
  @app.construction_waste_question_page.submit(choice: :no)
  @app.business_details_page.submit(
    company_name: "LT Sole Trader",
    postcode: "BS1 5AH",
    result: "ENVIRONMENT AGENCY, HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH"
  )
  @email = @app.generate_email
  @app.contact_details_page.submit(
    first_name: "Terry",
    last_name: "Griffiths",
    phone_number: "012345678",
    email: @email
  )
  @app.postal_address_page.submit
  @app.declaration_page.submit

  @app.sign_up_page.submit(
    registration_password: "Secret123",
    confirm_password: "Secret123",
    confirm_email: @email
  )
end

Given(/^I complete my application of my limited company as a lower tier waste carrier$/) do
  @app = FrontOfficeApp.new
  @app.start_page.load
  @app.start_page.submit
  @app.business_type_page.submit(org_type: "limitedCompany")
  @app.other_businesses_question_page.submit(choice: :no)
  @app.construction_waste_question_page.submit(choice: :no)
  @app.business_details_page.submit(
    company_name: "LT Company limited",
    postcode: "BS1 5AH",
    result: "ENVIRONMENT AGENCY, HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH"
  )
  @email = @app.generate_email
  @app.contact_details_page.submit(
    first_name: "Bob",
    last_name: "Carolgees",
    phone_number: "012345678",
    email: @email
  )
  @app.postal_address_page.submit
  @app.declaration_page.submit

  @app.sign_up_page.submit(
    registration_password: "Secret123",
    confirm_password: "Secret123",
    confirm_email: @email
  )
  puts @email
end
