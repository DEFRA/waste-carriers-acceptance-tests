Given(/^I have my limited company as a lower tier waste carrier registration completed for me$/) do
  @app.business_type_page.submit(org_type: "limitedCompany")
  @app.other_businesses_question_page.submit(choice: :yes)
  @app.service_provided_question_page.submit(choice: :main_service)
  @app.only_deal_with_question_page.submit(choice: :farm_waste)
  @app.business_details_page.submit(
    company_name: "AD LT Company limited",
    postcode: "BS1 5AH",
    result: "ENVIRONMENT AGENCY, HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH"
  )
  @app.contact_details_page.submit(
    first_name: "Bob",
    last_name: "Carolgees",
    phone_number: "012345678"
  )
  @app.postal_address_page.submit
  @app.declaration_page.submit

end
