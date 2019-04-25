When(/^I have my registration of my charity as a lower tier waste carrier completed for me$/) do
  @back_app.business_type_page.submit(org_type: "charity")
  @back_app.business_details_page.submit(
    company_name: "AD LT Charity",
    postcode: "BS1 5AH",
    result: "ENVIRONMENT AGENCY, HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH"
  )
  @back_app.contact_details_page.submit(
    first_name: "Bob",
    last_name: "Carolgees",
    phone_number: "012345678"
  )
  @back_app.postal_address_page.submit
  @back_app.check_details_page.submit
end

When(/^I have my registration of my local authority as a lower tier waste carrier completed for me$/) do
  @back_app.business_type_page.submit(org_type: "authority")
  @back_app.business_details_page.submit(
    company_name: "AD LT Local Authority",
    postcode: "BS1 5AH",
    result: "ENVIRONMENT AGENCY, HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH"
  )
  @back_app.contact_details_page.submit(
    first_name: "Bob",
    last_name: "Carolgees",
    phone_number: "012345678"
  )
  @back_app.postal_address_page.submit
  @back_app.check_details_page.submit
end

Given(/^I have my registration of my limited company as a lower tier waste carrier completed for me$/) do
  @back_app.business_type_page.submit(org_type: "limitedCompany")
  @back_app.other_businesses_question_page.submit(choice: :yes)
  @back_app.service_provided_question_page.submit(choice: :main_service)
  @back_app.only_deal_with_question_page.submit(choice: :farm_waste)
  @back_app.business_details_page.submit(
    company_name: "AD LT Company limited",
    postcode: "BS1 5AH",
    result: "ENVIRONMENT AGENCY, HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH"
  )
  @back_app.contact_details_page.submit(
    first_name: "Bob",
    last_name: "Carolgees",
    phone_number: "012345678"
  )
  @back_app.postal_address_page.submit
  @back_app.check_details_page.submit
end

When(/^I have my registration of my partnership as a lower tier waste carrier completed for me$/) do
  @back_app.business_type_page.submit(org_type: "partnership")
  @back_app.other_businesses_question_page.submit(choice: :yes)
  @back_app.service_provided_question_page.submit(choice: :not_main_service)
  @back_app.construction_waste_question_page.submit(choice: :no)
  @back_app.business_details_page.submit(
    company_name: "AD LT Partnership",
    postcode: "BS1 5AH",
    result: "ENVIRONMENT AGENCY, HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH"
  )
  @back_app.contact_details_page.submit(
    first_name: "Bob",
    last_name: "Carolgees",
    phone_number: "012345678"
  )
  @back_app.postal_address_page.submit
  @back_app.check_details_page.submit
end

When(/^I have my registration of my public body as a lower tier waste carrier completed for me$/) do
  @back_app.business_type_page.submit(org_type: "publicBody")
  @back_app.other_businesses_question_page.submit(choice: :yes)
  @back_app.service_provided_question_page.submit(choice: :main_service)
  @back_app.only_deal_with_question_page.submit(choice: :farm_waste)
  @back_app.business_details_page.submit(
    company_name: "AD LT Public Body",
    postcode: "BS1 5AH",
    result: "ENVIRONMENT AGENCY, HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH"
  )
  @back_app.contact_details_page.submit(
    first_name: "Bob",
    last_name: "Carolgees",
    phone_number: "012345678"
  )
  @back_app.postal_address_page.submit
  @back_app.check_details_page.submit
end

When(/^I have my sole trader business lower tier waste carrier registration completed for me$/) do
  @back_app.business_type_page.submit(org_type: "soleTrader")
  @back_app.other_businesses_question_page.submit(choice: :no)
  @back_app.construction_waste_question_page.submit(choice: :no)
  @back_app.business_details_page.submit(
    company_name: "AD LT Sole Trader",
    postcode: "BS1 5AH",
    result: "ENVIRONMENT AGENCY, HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH"
  )

  @back_app.contact_details_page.submit(
    first_name: "Terry",
    last_name: "Griffiths",
    phone_number: "012345678"
  )
  @back_app.postal_address_page.submit
  @back_app.check_details_page.submit
end
