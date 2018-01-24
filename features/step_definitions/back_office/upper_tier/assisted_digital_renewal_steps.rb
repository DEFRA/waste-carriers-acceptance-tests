Given(/^I have my public body upper tier registration completed for me$/) do
  @back_app = BackOfficeApp.new
  @back_app.agency_sign_in_page.load
  @back_app.agency_sign_in_page.submit(
    email: Quke::Quke.config.custom["accounts"]["agency_user"]["username"],
    password: ENV["WASTECARRIERSPASSWORD"]
  )
  @back_app.registrations_page.new_registration.click
  @back_app.start_page.submit
  @back_app.business_type_page.submit(org_type: "publicBody")
  @back_app.other_businesses_question_page.submit(choice: :no)
  @back_app.construction_waste_question_page.submit(choice: :yes)
  @back_app.registration_type_page.submit(choice: :broker_dealer)
  @back_app.business_details_page.submit(
    company_name: "AD UT Public Body",
    postcode: "S60 1BY",
    result: "ENVIRONMENT AGENCY, BOW BRIDGE CLOSE, ROTHERHAM, S60 1BY"
  )
  @back_app.contact_details_page.submit(
    first_name: "Bob",
    last_name: "Debuilder",
    phone_number: "012345678"
  )
  @back_app.postal_address_page.submit

  people = @back_app.key_people_page.key_people
  @back_app.key_people_page.submit_key_person(person: people[0])

  @back_app.relevant_convictions_page.submit(choice: :no)
  @back_app.check_details_page.submit
  @back_app.order_page.submit(
    copy_card_number: "2",
    choice: :card_payment
  )
  click(@back_app.worldpay_card_choice_page.maestro)

  # finds today's date and adds another year to expiry date
  time = Time.new

  @year = time.year + 1

  @back_app.worldpay_card_details_page.submit(
    card_number: "6759649826438453",
    security_code: "555",
    cardholder_name: "3d.authorised",
    expiry_month: "12",
    expiry_year: @year
  )
  # Stores registration number and access code for later use
  @registration_number = @back_app.finish_assisted_page.registration_number.text
  @access_code = @back_app.finish_assisted_page.access_code.text
end

When(/^I have my public body upper tier renewal completed for me$/) do
  @back_app.agency_sign_in_page.load
  @back_app.registrations_page.search(search_input: @registration_number)
  @back_app.registrations_page.search_results[0].renew.click
  @back_app.business_type_page.submit
  @back_app.other_businesses_question_page.submit(choice: :no)
  @back_app.construction_waste_question_page.submit(choice: :yes)
  @back_app.registration_type_page.submit
  @back_app.renewal_information_page.submit
  @back_app.post_code_page.submit(postcode: "S60 1BY")
  @back_app.business_address_page.submit(
    result: "ENVIRONMENT AGENCY, BOW BRIDGE CLOSE, ROTHERHAM, S60 1BY"
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
