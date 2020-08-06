Given("I generate errors throughout the journey") do

  # Currently covers registrations. We may want to expand this to cover renewals too.
  @organisation_type = "limitedCompany"

  @journey.start_page.load
  @journey.start_page.submit
  expect(@journey.start_page.error_summary).to have_text("You must answer this question")
  @journey.start_page.submit(choice: @resource_object)

  @journey.location_page.submit
  expect(@journey.location_page.error_summary).to have_text("Select your principal place of business")
  @journey.location_page.submit(choice: "england")

  @journey.confirm_business_type_page.submit
  expect(@journey.confirm_business_type_page.error_summary).to have_text("Select type of business or organisation")
  @journey.confirm_business_type_page.submit(org_type: @organisation_type)

  @journey.check_your_tier_page.submit
  expect(@journey.check_your_tier_page.error_summary).to have_text("Select help me decide, upper tier or lower tier")
  @journey.check_your_tier_page.submit(option: :unknown)

  @journey.tier_other_businesses_page.submit
  expect(@journey.tier_other_businesses_page.error_summary).to have_text("Select yes or no")
  @journey.tier_other_businesses_page.submit(choice: :yes)

  @journey.tier_service_provided_page.submit
  expect(@journey.tier_service_provided_page.error_summary).to have_text("Select who creates the waste")
  @journey.tier_service_provided_page.submit(choice: :not_main_service)

  @journey.tier_construction_waste_page.submit
  expect(@journey.tier_construction_waste_page.error_summary).to have_text("Select yes or no")
  @journey.tier_construction_waste_page.back_link.click
  @journey.tier_service_provided_page.submit(choice: :main_service)

  @journey.tier_farm_only_page.submit
  expect(@journey.tier_farm_only_page.error_summary).to have_text("Select the types of waste you deal with")
  @journey.tier_farm_only_page.submit(choice: :no)

  # You need to register as upper tier
  @journey.standard_page.submit
  @journey.carrier_type_page.submit
  expect(@journey.carrier_type_page.error_summary).to have_text("Select who carries the waste")
  @journey.carrier_type_page.submit(choice: :carrier_broker_dealer)

  @journey.company_number_page.submit
  expect(@journey.company_number_page.error_summary).to have_text("Enter a company registration number")
  @journey.company_number_page.submit(companies_house_number: "123456789")
  expect(@journey.company_number_page.error_summary).to have_text("Enter a valid number - it should have 8 digits, or 2 letters followed by 6 digits, or 2 letters followed by 5 digits and another letter. If your number has only 7 digits, enter it with a zero at the start.")
  @journey.company_number_page.submit(companies_house_number: "00445790")

  @business_name = "Validation test"
  @journey.company_name_page.submit
  expect(@journey.company_name_page.error_summary).to have_text("You must enter a trading name")
  @journey.company_name_page.submit(company_name: @business_name)

  test_address_validations

  @people = @journey.company_people_page.main_people
  @journey.company_people_page.submit
  expect(@journey.company_people_page.error_summary).to have_text("You must add the details of at least one person")
  @journey.company_people_page.submit(
    first_name: "Brian",
    last_name: "Butterfield"
  )
  expect(@journey.company_people_page.error_summary).to have_text("You must enter a valid date")
  @journey.company_people_page.submit_main_person(person: @people[0])

  @journey.conviction_declare_page.submit
  expect(@journey.conviction_declare_page.error_summary).to have_text("Select yes or no")
  @journey.conviction_declare_page.submit(choice: :yes)

  @journey.conviction_details_page.submit_button.click
  expect(@journey.conviction_details_page.error_summary).to have_text("You must add the details of at least one person")
  @relevant_people = @old.relevant_people_page.relevant_people
  @journey.conviction_details_page.submit(person: @relevant_people[0])

  @journey.contact_name_page.submit
  expect(@journey.contact_name_page.error_summary).to have_text("You must enter a first name\nYou must enter a last name")
  @journey.contact_name_page.submit(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name
  )
  @journey.contact_phone_page.submit
  expect(@journey.contact_phone_page.error_summary).to have_text("Enter a telephone number")
  @journey.contact_phone_page.submit(phone_number: "0117 4960000")

  @journey.contact_email_page.submit
  expect(@journey.contact_email_page.error_summary).to have_text("Enter an email address\nEnter your email address again to confirm it")
  @journey.contact_email_page.submit(
    email: "user@example.com",
    confirm_email: "another-user@example.com"
  )
  expect(@journey.contact_email_page.error_summary).to have_text("The email addresses you’ve entered don’t match")
  @email_address = generate_email
  @journey.contact_email_page.submit(email: @email_address, confirm_email: @email_address)

  test_address_validations

  expect(page).to have_content("Check your answers")
  @journey.standard_page.submit

  @journey.declaration_page.submit_button.click
  expect(@journey.declaration_page.error_summary).to have_text("You cannot continue if you do not understand and agree with the declaration")
  @journey.declaration_page.submit

  @journey.registration_cards_page.submit(cards: 1000)
  expect(@journey.registration_cards_page.error_summary).to have_text("Enter 0 or a number between 1 and 999")
  @journey.registration_cards_page.submit(cards: 3)

  @journey.payment_summary_page.submit
  expect(@journey.payment_summary_page.error_summary).to have_text("You must select a payment method")
  @journey.payment_summary_page.submit(
    choice: :card_payment,
    email: ""
  )
  expect(@journey.payment_summary_page.error_summary).to have_text("Enter an email address")
  @journey.payment_summary_page.submit(
    choice: :card_payment,
    email: "receipt-email@example.com"
  )

  submit_valid_card_payment
end

Then("I am notified that my application has been received") do
  expect(@journey.confirmation_page.heading).to have_text("Application received")
  expect(@journey.confirmation_page.content).to have_text("check your details and let you know whether your application has been successful")
  expect(@journey.confirmation_page.content).to have_text("receipt-email@example.com")
  @reg_number = @journey.confirmation_page.registration_number.text
  puts @reg_number + " submitted and pending convictions"
end
