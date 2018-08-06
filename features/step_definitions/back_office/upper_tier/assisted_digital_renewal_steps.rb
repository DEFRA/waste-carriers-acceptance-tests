When(/^I have my public body upper tier renewal completed for me$/) do
  @back_app.agency_sign_in_page.load
  @back_app.registrations_page.search(search_input: @registration_number)
  @back_app.registrations_page.search_results[0].renew.click
  @back_app.business_type_page.submit
  @back_app.other_businesses_question_page.submit(choice: :no)
  @back_app.construction_waste_question_page.submit(choice: :yes)
  @back_app.registration_type_page.submit(choice: :carrier_broker_dealer)
  @back_app.renewal_information_page.submit
  @back_app.post_code_page.submit(postcode: "BS1 5AH")
  @back_app.business_address_page.submit(
    result: "NATURAL ENGLAND, HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH"
  )
  people = @back_app.key_people_page.key_people

  @back_app.key_people_page.submit_key_person(person: people[0])
  @back_app.relevant_convictions_page.submit(choice: :no)
  @back_app.correspondence_contact_name_page.submit
  @back_app.correspondence_contact_telephone_page.submit
  @back_app.correspondence_contact_email_page.submit
  @back_app.contact_address_page.submit
  @back_app.check_details_page.submit_button.click
end

Then(/^my registration will have been renewed$/) do
  expect(@back_app.finish_assisted_page.registration_number).to have_text("CBDU")
  expect(@back_app.finish_assisted_page).to have_access_code
  expect(@back_app.finish_assisted_page).to have_text("Renewal complete")
end
