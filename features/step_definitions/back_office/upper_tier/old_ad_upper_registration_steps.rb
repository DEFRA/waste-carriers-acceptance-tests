When(/^I have my limited company upper tier registration completed for me on backend$/) do
  @old.old_business_type_page.submit(org_type: "limitedCompany")
  @old.other_businesses_question_page.submit(choice: :no)
  @old.construction_waste_question_page.submit(choice: :yes)
  @old.registration_type_page.submit(choice: :carrier_broker_dealer)
  @old.business_details_page.submit(
    companies_house_number: "00445790",
    company_name: "AD UT Company limited",
    postcode: "BS1 5AH",
    result: "HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH"
  )
  @old.contact_details_page.submit(
    first_name: "Bob",
    last_name: "Carolgees",
    phone_number: "0117 4960000"
  )
  @old.postal_address_page.submit

  people = @old.key_people_page.key_people

  @old.key_people_page.add_key_person(person: people[0])
  @old.key_people_page.add_key_person(person: people[1])
  @old.key_people_page.submit_key_person(person: people[2])

  @old.relevant_convictions_page.submit(choice: :no)
  @old.check_details_page.submit
end

When(/^I have my partnership upper tier regstration completed for me on backend$/) do
  @old.old_business_type_page.submit(org_type: "partnership")
  @old.other_businesses_question_page.submit(choice: :yes)
  @old.service_provided_question_page.submit(choice: :main_service)
  @old.only_deal_with_question_page.submit(choice: :not_farm_waste)
  @old.registration_type_page.submit(choice: :broker_dealer)
  @old.business_details_page.submit(
    company_name: "AD Upper Tier Partnership",
    postcode: "BS1 5AH",
    result: "HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH"
  )
  @old.contact_details_page.submit(
    first_name: "Bob",
    last_name: "Carolgees",
    phone_number: "0117 4960000"
  )
  @old.postal_address_page.submit

  people = @old.key_people_page.key_people

  @old.key_people_page.add_key_person(person: people[0])
  @old.key_people_page.add_key_person(person: people[1])
  @old.key_people_page.submit_key_person(person: people[2])

  @old.relevant_convictions_page.submit(choice: :no)
  @old.check_details_page.submit
end

When(/^I have my public body upper tier registration completed for me on backend$/) do
  @old.old_business_type_page.submit(org_type: "publicBody")
  @old.other_businesses_question_page.submit(choice: :no)
  @old.construction_waste_question_page.submit(choice: :yes)
  @old.registration_type_page.submit(choice: :broker_dealer)
  @old.business_details_page.submit(
    company_name: "AD UT Public Body",
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
