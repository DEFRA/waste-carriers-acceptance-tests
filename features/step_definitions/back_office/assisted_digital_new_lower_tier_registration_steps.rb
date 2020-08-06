When(/^I have my registration of my charity as a lower tier waste carrier completed for me$/) do
  @old.old_business_type_page.submit(org_type: "charity")
  @old.business_details_page.submit(
    company_name: "AD LT Charity",
    postcode: "BS1 5AH",
    result: "HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH"
  )
  @old.contact_details_page.submit(
    first_name: "Bob",
    last_name: "Carolgees",
    phone_number: "0117 4960000"
  )
  @old.postal_address_page.submit
  @old.check_details_page.submit
end

When(/^I have my registration of my local authority as a lower tier waste carrier completed for me$/) do
  @old.old_business_type_page.submit(org_type: "authority")
  @old.business_details_page.submit(
    company_name: "AD LT Local Authority",
    postcode: "BS1 5AH",
    result: "HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH"
  )
  @old.contact_details_page.submit(
    first_name: "Bob",
    last_name: "Carolgees",
    phone_number: "0117 4960000"
  )
  @old.postal_address_page.submit
  @old.check_details_page.submit
end

Given(/^I have my registration of my limited company as a lower tier waste carrier completed for me$/) do
  @old.old_business_type_page.submit(org_type: "limitedCompany")
  @old.other_businesses_question_page.submit(choice: :yes)
  @old.service_provided_question_page.submit(choice: :main_service)
  @old.only_deal_with_question_page.submit(choice: :farm_waste)
  @old.business_details_page.submit(
    company_name: "AD LT Company limited",
    postcode: "BS1 5AH",
    result: "HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH"
  )
  @old.contact_details_page.submit(
    first_name: "Bob",
    last_name: "Carolgees",
    phone_number: "0117 4960000"
  )
  @old.postal_address_page.submit
  @old.check_details_page.submit
end

When(/^I have my registration of my partnership as a lower tier waste carrier completed for me$/) do
  @old.old_business_type_page.submit(org_type: "partnership")
  @old.other_businesses_question_page.submit(choice: :yes)
  @old.service_provided_question_page.submit(choice: :not_main_service)
  @old.construction_waste_question_page.submit(choice: :no)
  @old.business_details_page.submit(
    company_name: "AD LT Partnership",
    postcode: "BS1 5AH",
    result: "HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH"
  )
  @old.contact_details_page.submit(
    first_name: "Bob",
    last_name: "Carolgees",
    phone_number: "0117 4960000"
  )
  @old.postal_address_page.submit
  @old.check_details_page.submit
end

When(/^I have my registration of my public body as a lower tier waste carrier completed for me$/) do
  @old.old_business_type_page.submit(org_type: "publicBody")
  @old.other_businesses_question_page.submit(choice: :yes)
  @old.service_provided_question_page.submit(choice: :main_service)
  @old.only_deal_with_question_page.submit(choice: :farm_waste)
  @old.business_details_page.submit(
    company_name: "AD LT Public Body",
    postcode: "BS1 5AH",
    result: "HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH"
  )
  @old.contact_details_page.submit(
    first_name: "Bob",
    last_name: "Carolgees",
    phone_number: "0117 4960000"
  )
  @old.postal_address_page.submit
  @old.check_details_page.submit
end

When(/^I have my sole trader business lower tier waste carrier registration completed for me$/) do
  @old.old_business_type_page.submit(org_type: "soleTrader")
  @old.other_businesses_question_page.submit(choice: :no)
  @old.construction_waste_question_page.submit(choice: :no)
  @old.business_details_page.submit(
    company_name: "AD LT Sole Trader",
    postcode: "BS1 5AH",
    result: "HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH"
  )

  @old.contact_details_page.submit(
    first_name: "Terry",
    last_name: "Griffiths",
    phone_number: "0117 4960000"
  )
  @old.postal_address_page.submit
  @old.check_details_page.submit
end
