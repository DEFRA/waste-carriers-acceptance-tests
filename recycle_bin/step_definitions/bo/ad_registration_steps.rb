When(/^I have my sole trader upper tier waste carrier application completed for me$/) do
  @old.old_business_type_page.submit(org_type: "soleTrader")
  old_select_upper_tier_options("carrier_broker_dealer")
  @old.business_details_page.submit(
    company_name: "AD UT Sole Trader",
    postcode: "BS1 5AH",
    result: "HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH"
  )
  @old.contact_details_page.submit(
    first_name: "Bob",
    last_name: "Debuilder",
    phone_number: "0117 4960000"
  )
  @old.postal_address_page.submit

  people = @old.key_people_page.key_people
  @old.key_people_page.submit_key_person(person: people[0])

  @old.relevant_convictions_page.submit(choice: :no)
  @old.check_details_page.submit
end
