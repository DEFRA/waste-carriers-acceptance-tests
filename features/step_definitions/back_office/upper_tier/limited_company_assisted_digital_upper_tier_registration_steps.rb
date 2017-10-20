When(/^I have my limited company as a upper tier waste carrier registration completed for me$/) do
  @app.business_type_page.submit(org_type: "limitedCompany")
  @app.other_businesses_question_page.submit(choice: :no)
  @app.construction_waste_question_page.submit(choice: :yes)
  @app.registration_type_page.submit(choice: :carrier_broker_dealer)
  @app.business_details_page.submit(
    companies_house_number: "00233462",
    company_name: "AD UT Company limited",
    postcode: "BS1 5AH",
    result: "ENVIRONMENT AGENCY, HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH"
  )
  @app.contact_details_page.submit(
    first_name: "Bob",
    last_name: "Carolgees",
    phone_number: "012345678"
  )
  @app.postal_address_page.submit

  people = @app.key_people_page.key_people

  @app.key_people_page.add_key_person(person: people[0])
  @app.key_people_page.add_key_person(person: people[1])
  @app.key_people_page.submit_key_person(person: people[2])

  @app.relevant_convictions_page.submit(choice: :no)
  @app.declaration_page.submit
  @app.order_page.submit(
    copy_card_number: "1",
    choice: :card_payment
  )
  @app.worldpay_card_choice_page.maestro.click

  # finds today's date and adds another year to expiry date
  time = Time.new

  @year = time.year + 1

  @app.worldpay_card_details_page.submit(
    card_number: "6759649826438453",
    security_code: "555",
    cardholder_name: "3d.authorised",
    expiry_month: "12",
    expiry_year: @year
  )
end
