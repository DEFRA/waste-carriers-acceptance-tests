# Naming convention: prefix all functions on the old apps with "old_"

def old_start_internal_registration
  @old.backend_registrations_page.new_registration.click
  @old.old_start_page.submit
  expect(@journey.location_page.heading).to have_text("Where is your principal place of business?")
  @journey.location_page.submit(choice: :england)
end

def old_submit_carrier_details(business, tier, carrier)
  @old.old_business_type_page.submit(org_type: business)
  if tier == "upper"
    old_select_upper_tier_options(carrier)
  else
    old_select_lower_tier_options
  end
end

def submit_carrier_details(business, tier, carrier)
  # Select the org type, or just click submit if the business is "existing"
  @journey.confirm_business_type_page.submit(org_type: business)

  # Covers tier and carrier type (if applicable) for registrations and renewals
  # Select the org type, or just click submit if the business is "existing"
  case tier
  when "lower"
    select_random_lower_tier_options if business != "charity" # if so, questions are skipped
    # "You need to register as a lower tier waste carrier"
    @journey.standard_page.submit
  when "existing"
    # this only applies to renewals:
    @journey.tier_check_page.submit(choice: :skip_check)
    @journey.carrier_type_page.submit(choice: carrier.to_sym)
  else
    # Assume it's an upper tier new registration.
    # This method does not cover renewals with changed tier.
    select_tier_for_registration(carrier)
  end
end

def select_tier_for_registration(carrier)
  select_random_upper_tier_route
  @journey.carrier_type_page.submit(choice: carrier.to_sym)
end

def select_tier_for_renewal(carrier)
  @journey.tier_check_page.submit(choice: :check_tier)
  answer_random_upper_tier_questions
  # Carrier options (same for old and new apps):
  # carrier_broker_dealer, broker_dealer, carrier_dealer, existing
  @journey.carrier_type_page.submit(choice: carrier.to_sym)
  # "Confirmation of your renewal so far":
  @journey.standard_page.submit
end

def select_random_upper_tier_route
  # Only applies to registrations.

  i = rand(2)
  if i.zero?
    # go through routing questions to check your tier.
    @journey.check_your_tier_page.submit(option: :unknown)
    answer_random_upper_tier_questions
    # "You need to register as an upper tier waste carrier":
    @journey.standard_page.submit
  else
    # select "I know I need an upper tier registration":
    @journey.check_your_tier_page.submit(option: :upper)
  end
end

def answer_random_upper_tier_questions
  # Randomise between 3 ways to achieve an upper tier registration:
  i = rand(3)
  if i.zero?
    @journey.tier_other_businesses_page.submit(choice: :yes)
    @journey.tier_service_provided_page.submit(choice: :not_main_service)
    @journey.tier_construction_waste_page.submit(choice: :yes)
  elsif i == 1
    @journey.tier_other_businesses_page.submit(choice: :yes)
    @journey.tier_service_provided_page.submit(choice: :main_service)
    @journey.tier_farm_only_page.submit(choice: :no)
  else
    @journey.tier_other_businesses_page.submit(choice: :no)
    @journey.tier_construction_waste_page.submit(choice: :yes)
  end
end

def select_random_lower_tier_options
  i = rand(2)
  if i.zero?
    @journey.check_your_tier_page.submit(option: :unknown)

    answer_random_lower_tier_questions

    # Proceed from "You need to register as a lower tier waste carrier":
    @journey.standard_page.submit
  else
    @journey.check_your_tier_page.submit(option: :lower)
  end
end

def answer_random_lower_tier_questions
  # Randomise between 3 ways to achieve an lower tier registration:
  i = rand(3)
  if i.zero?
    @journey.tier_other_businesses_page.submit(choice: :no)
    @journey.tier_construction_waste_page.submit(choice: :no)
  elsif i == 1
    @journey.tier_other_businesses_page.submit(choice: :yes)
    @journey.tier_service_provided_page.submit(choice: :main_service)
    @journey.tier_farm_only_page.submit(choice: :yes)
  else
    @journey.tier_other_businesses_page.submit(choice: :yes)
    @journey.tier_service_provided_page.submit(choice: :not_main_service)
    @journey.tier_construction_waste_page.submit(choice: :no)
  end
end

def old_select_upper_tier_options(carrier)
  @old.other_businesses_question_page.submit(choice: :no)
  @old.construction_waste_question_page.submit(choice: :yes)
  @old.registration_type_page.submit(choice: carrier.to_sym)
end

def old_select_lower_tier_options
  @old.other_businesses_question_page.submit(choice: :no)
  @old.construction_waste_question_page.submit(choice: :no)
end

def old_submit_business_details(business_name, tier)
  if @old.business_details_page.heading.has_text? "Business details"
    # then it's a limited company:
    old_submit_limited_company_details(business_name, tier)
  else
    old_submit_organisation_details(business_name)
  end
end

def submit_business_details(business_name, tier)
  # submits company number, name and address
  if @journey.company_number_page.heading.has_text? "What's the registration number"
    # then it's a limited company or LLP:
    submit_limited_company_details(business_name, tier)
  else
    # it'll be the company name page, which will have a heading like "What's the name of the business?"
    submit_organisation_details(business_name)
  end
end

def old_submit_limited_company_details(business_name, tier)
  # Remove this function once tech debt is complete for registrations
  if tier == "upper"
    @old.business_details_page.submit(
      companies_house_number: "00445790",
      company_name: business_name,
      postcode: "BS1 5AH",
      result: "HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH"
    )
  else
    # Companies House number is not requested for lower tier
    @old.business_details_page.submit(
      company_name: business_name,
      postcode: "BS1 5AH",
      result: "HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH"
    )
  end
end

def submit_limited_company_details(business_name, tier)
  # Submit company number:
  if tier == "upper"
    @companies_house_number ||= "00445790"
    @journey.company_number_page.submit(companies_house_number: @companies_house_number)
  end

  if business_name == "existing"
    @journey.company_name_page.submit
  else
    @journey.company_name_page.submit(company_name: business_name)
  end

  complete_address_with_random_method
end

def complete_address_with_random_method
  i = rand(0..2)
  if i.zero?
    # Submit address manually
    @journey.address_lookup_page.choose_manual_address
    @journey.address_manual_page.submit(
      house_number: "1",
      address_line_one: "Test lane",
      address_line_two: "Testville",
      city: "Teston"
    )
  else
    # Do a lookup
    @journey.address_lookup_page.submit_valid_address
  end
end

def submit_manual_address
  @journey.address_lookup_page.submit_invalid_address
  @journey.address_manual_page.submit(
    house_number: "1",
    address_line_one: "Test lane",
    address_line_two: "Testville",
    city: "Teston"
  )
end

def old_submit_organisation_details(business_name)
  # Remove this function once tech debt is complete for registrations
  @old.business_details_page.submit(
    company_name: business_name,
    postcode: "BS1 5AH",
    result: "HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH"
  )
end

def submit_organisation_details(business_name)
  @journey.company_name_page.submit(company_name: business_name)
  complete_address_with_random_method
end

def old_submit_company_people(business)
  people = @old.key_people_page.key_people
  @old.key_people_page.add_key_person(person: people[0]) if business == "partnership"
  @old.key_people_page.submit_key_person(person: people[1])
end

def submit_company_people
  # Submits an appropriate number of people based on business type
  # and returns the people. Use ||= in case @people has been previously defined to be people with convictions.
  @people ||= @journey.company_people_page.main_people

  # If they are a sole trader then only one person can be added here.
  heading = @journey.company_people_page.heading.text
  if heading != "Business owner details"
    # then they're not a sole trader, so add more people:
    @journey.company_people_page.add_main_person(person: @people[0])
    @journey.company_people_page.add_main_person(person: @people[1])
  end

  @journey.company_people_page.submit_main_person(person: @people[2])
end

def test_partnership_people
  # Check that removing a partner means you can't continue with a registration.
  people = @journey.company_people_page.main_people
  @journey.company_people_page.add_main_person(person: people[0])
  @journey.company_people_page.add_main_person(person: people[1])
  @journey.company_people_page.remove_person[0].click
  @journey.company_people_page.submit_button.click
  expect(@journey.company_people_page).to have_text("You must add the details of at least 2 people")
  @journey.company_people_page.submit_main_person(person: people[2])
end

def old_submit_convictions(convictions)
  if convictions == "no convictions"
    @old.relevant_convictions_page.submit(choice: :no)
  else
    @old.relevant_convictions_page.submit(choice: :yes)
    people = @old.relevant_people_page.relevant_people
    @old.relevant_people_page.submit_relevant_person(person: people[0])
  end
end

def submit_convictions(convictions)
  if convictions == "no convictions"
    @journey.conviction_declare_page.submit(choice: :no)
  else
    @journey.conviction_declare_page.submit(choice: :yes)
    people = @journey.conviction_details_page.main_people
    @journey.conviction_details_page.submit(person: people[0])
  end
end

def old_submit_contact_details_from_bo
  @old.contact_details_page.submit(
    first_name: "Bob",
    last_name: "Carolgees",
    phone_number: "0117 4960000" # fake number from Ofcom site
  )
  @old.postal_address_page.submit
  # Back office doesn't have the ability to add a contact address for assisted digital renewals
end

def submit_contact_details_for_renewal
  # Contact details are not replayed as per RUBY-1171.
  last_name_value = @journey.contact_name_page.last_name.value
  expect(last_name_value).to eq("")
  @journey.contact_name_page.submit(
    first_name: "Peek",
    last_name: "Freans"
  )

  phone_value = @journey.contact_phone_page.phone_number.value
  expect(phone_value).to eq("")
  @journey.contact_phone_page.submit(phone_number: "0117 4960001")

  email_value = @journey.contact_email_page.email.value
  expect(email_value).to eq("")
  @journey.contact_email_page.submit(
    email: "bo-renewal@example.com",
    confirm_email: "bo-renewal@example.com"
  )

  complete_address_with_random_method
end

def submit_contact_details_for_registration(email_address)
  names = {
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name
  }
  @journey.contact_name_page.submit(names)
  @journey.contact_phone_page.submit(phone_number: "0117 4960000")
  @journey.contact_email_page.submit(email: email_address, confirm_email: email_address)
  complete_address_with_random_method
end

def old_check_your_answers
  @old.check_details_page.submit
end

def check_your_answers
  @journey.check_your_answers_page.submit
  @journey.declaration_page.submit
end

def old_order_cards_during_journey(number_of_cards)
  @old.old_order_page.submit(
    copy_card_number: number_of_cards,
    choice: :card_payment
  )
end

def order_cards_during_journey(number_of_cards)
  if number_of_cards.zero?
    @journey.registration_cards_page.submit
  else
    @journey.registration_cards_page.submit(cards: number_of_cards)
  end
end

def old_complete_registration_from_bo(business, tier, carrier)
  expect(@old.finish_assisted_page.registration_number).to have_text("CBD")
  expect(@old.finish_assisted_page.heading).to have_text("Registration complete")
  expect(@old.finish_assisted_page).to have_view_certificate

  # Stores registration number for later use
  @reg_number = @old.finish_assisted_page.registration_number.text
  puts "Registration " + @reg_number + " completed for " + tier + " tier " + business + " " + carrier
  @reg_number
end

def check_registration_details(reg)
  find_link("Registrations search").click
  @bo.dashboard_page.view_reg_details(search_term: reg)
  expect(@bo.registration_details_page.heading).to have_text("Registration " + reg)
end

def test_address_validations
  # Cycle through possible error messages on shared address pages
  test_lookup_address_validations
  test_manual_address_validations
end

def test_lookup_address_validations
  test_invalid_postcodes
  @journey.address_lookup_page.enter_postcode("BS1 5AH")
  @journey.address_lookup_page.submit_button.click
  expect(@journey.address_lookup_page.error_summary).to have_text("You must select an address")
end

def test_invalid_postcodes
  @journey.address_lookup_page.enter_postcode("")
  expect(@journey.address_lookup_page.error_summary).to have_text("Enter a postcode")
  @journey.address_lookup_page.enter_postcode("cheese")
  expect(@journey.address_lookup_page.error_summary).to have_text("Enter a valid UK postcode")
  @journey.address_lookup_page.enter_postcode("BS1 9XX")
  expect(@journey.address_lookup_page.error_summary).to have_text("We cannot find any addresses for that postcode. Check the postcode or enter the address manually.")
end

def test_manual_address_validations
  @journey.address_lookup_page.manual_address.click
  @journey.address_manual_page.submit
  expect(@journey.address_manual_page.error_summary).to have_text("Enter the building name or number\nEnter an address line 1\nEnter a town or city")
  @journey.address_manual_page.submit(
    house_number: "1",
    address_line_one: "Elm lane",
    address_line_two: "Snnnnnnn",
    city: "Wilson"
  )
end
