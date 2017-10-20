When(/^I have my sole trader business lower tier waste carrier registration completed for me$/) do
  @app.business_type_page.submit(org_type: "soleTrader")
  @app.other_businesses_question_page.submit(choice: :no)
  @app.construction_waste_question_page.submit(choice: :no)
  @app.business_details_page.submit(
    company_name: "AD LT Sole Trader",
    postcode: "BS1 5AH",
    result: "ENVIRONMENT AGENCY, HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH"
  )

  @app.contact_details_page.submit(
    first_name: "Terry",
    last_name: "Griffiths",
    phone_number: "012345678"
  )
  @app.postal_address_page.submit
  @app.declaration_page.submit
end
