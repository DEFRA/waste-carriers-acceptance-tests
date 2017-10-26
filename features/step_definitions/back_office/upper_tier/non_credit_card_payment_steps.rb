Given(/^I have an application that is pending payment$/) do
  @app = FrontOfficeApp.new
  @app.start_page.load
  @app.start_page.submit
  @app.business_type_page.submit(org_type: "soleTrader")
  @app.other_businesses_question_page.submit(choice: :yes)
  @app.service_provided_question_page.submit(choice: :not_main_service)
  @app.construction_waste_question_page.submit(choice: :yes)
  @app.registration_type_page.submit(choice: :carrier_dealer)
  @app.business_details_page.submit(
    company_name: "Offline payment",
    postcode: "BS1 5AH",
    result: "ENVIRONMENT AGENCY, HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH"
  )
  @email = @app.generate_email
  @app.contact_details_page.submit(
    first_name: "Bob",
    last_name: "Debuilder",
    phone_number: "012345678",
    email: @email
  )
  @app.postal_address_page.submit

  people = @app.key_people_page.key_people
  @app.key_people_page.submit_key_person(person: people[0])

  @app.relevant_convictions_page.submit(choice: :no)
  @app.declaration_page.submit
  @app.sign_up_page.submit(
    registration_password: "Secret123",
    confirm_password: "Secret123",
    confirm_email: @email
  )
    @app.order_page.submit(
    copy_card_number: "2",
    choice: :bank_transfer_payment
  )
  @app.offline_payment_page.submit
  # Stores registration number for later use
  @uppertier_registration_number = @app.registration_confirmed_page.registration_number.text
end

When(/^I enter a payment for the full amount owed$/) do
  @app.registrations_page.search(search_input: @uppertier_registration_number)
  @app.registrations_page.first_search_result_payment_status.click
  @app.payment_status_page.enter_payment.click
  # Finds the amount needed to be paid and strips off the £ sign
  @amount_due = @app.payments_page.amount_due.text[1..-1]
  puts @amount_due

  @app.payments_page.submit(
  	payment_amount: @amount_due,
  	payment_day: "1",
  	payment_month: "1",
  	payment_year: "2017",
  	payment_ref: "Test",
  	payment_type: "CASH",
  	payment_comment: "manual payment"
  	)

end

Then(/^the registration will be marked as complete$/) do
  pending # Write code here that turns the phrase above into concrete actions
end