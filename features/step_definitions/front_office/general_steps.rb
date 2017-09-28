Given(/^I start a new registration$/) do
  @app = FrontOfficeApp.new
  @app.start_page.load
  @app.start_page.submit
end

Given(/^I complete my registration of my limited company as a lower tier waste carrier$/) do
  @app.business_type_page.submit(org_type: "limitedCompany")
  # @app.check_operator_page.submit(company_number: "12345678")
  @app.other_businesses_question_page.submit(choice: :no)
  @app.construction_waste_question_page.submit(choice: :no)
  @app.business_details_page.submit(
  	company_name: "LT Company limited",
  	postcode: "BS1 5AH",
  	result: "ENVIRONMENT AGENCY, HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH"
  	)
  @app.contact_details_page.submit(
  first_name: "Bob",
  last_name: "Carolgees",
  phone_number: "012345678",
  email: "tim.stone.ea@gmail.com"
  	)
end

Then(/^I will be registered as lower tier waste carrier$/) do
  pending # Write code here that turns the phrase above into concrete actions
end
