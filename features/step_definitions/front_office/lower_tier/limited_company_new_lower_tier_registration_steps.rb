Given(/^I complete my registration of my limited company as a lower tier waste carrier$/) do
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
end

Then(/^I will be asked to confirm my email address$/) do
  expect(@app.confirm_account_page.has_content?("Confirm your email address")).to be(true)
end
