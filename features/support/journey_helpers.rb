# Naming convention: prefix all functions on the old apps with "old_"

def old_start_internal_registration
  @back_app.registrations_page.new_registration.click
  @back_app.start_page.submit
  expect(@back_app.location_page.heading).to have_text("Where is your principal place of business?")
  @back_app.location_page.submit(choice: :england)
end

def old_submit_carrier_details(business, tier, carrier)
  if tier == "upper"
    @back_app.business_type_page.submit(org_type: business)
    old_select_upper_tier_options(carrier)
  else
    puts "Put old app lower tier steps here"
  end
end

def submit_carrier_details(business, tier, carrier)
  # Select the org type, or just click submit if the business is "existing"
  @journey.confirm_business_type_page.submit(org_type: business)
  # Allow option: if any details are "existing" then use what came before - eg "I know I need an upper tier reg"
  if tier == "existing"
    @journey.tier_check_page.submit(choice: :skip_check)
    @journey.carrier_type_page.submit(choice: carrier.to_sym)
  else
    @journey.tier_check_page.submit(choice: :check_tier)
    select_upper_tier_options(carrier)
  end
end

def old_select_upper_tier_options(carrier)
  @back_app.other_businesses_question_page.submit(choice: :no)
  @back_app.construction_waste_question_page.submit(choice: :yes)
  @back_app.registration_type_page.submit(choice: carrier.to_sym)
end

def select_upper_tier_options(carrier)
  # Combine these pages into @journey:
  @renewals_app.other_businesses_page.submit(choice: :yes)
  @renewals_app.service_provided_page.submit(choice: :not_main_service)
  @renewals_app.construction_waste_page.submit(choice: :yes)
  # Question: are the carrier types the same for old and new apps? If tests pass then delete this comment.
  @journey.carrier_type_page.submit(choice: carrier.to_sym)
end

def old_submit_business_details
  if @back_app.business_details_page.heading.has_text? "Business details"
    # then it's a limited company:
    business_name = "AD UT Company limited"
    old_submit_limited_company_details(business_name)
  else
    business_name = "AD UT Organisation limited"
    old_submit_organisation_details(business_name)
  end
  business_name
end

def submit_business_details
  if @journey.company_number_page.heading.has_text? "What's the registration number of the company?"
    # then it's a limited company:
    business_name = "AD Renewal Ltd"
    submit_limited_company_details(business_name)
  else
    # it'll be the company name page, which will have a heading like "What's the name of the business?"
    business_name = "AD Renewal Organisation"
    submit_organisation_details(business_name)
  end
  business_name
end

def old_submit_limited_company_details(business_name)
  # Remove this function once tech debt is complete for registrations
  @back_app.business_details_page.submit(
    companies_house_number: "00445790",
    company_name: business_name,
    postcode: "BS1 5AH",
    result: "ENVIRONMENT AGENCY, HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH"
  )
end

def submit_limited_company_details(business_name)
  # Submit existing company number:
  @journey.company_number_page.submit
  @journey.company_name_page.submit(company_name: business_name)
  # TODO: Create functions for lookup and manual addresses, and randomise it
  @journey.address_lookup_page.choose_manual_address
  @journey.address_manual_page.submit(
    house_number: "1",
    address_line_one: "Test lane",
    address_line_two: "Testville",
    city: "Teston"
  )
end

def old_submit_organisation_details(business_name)
  # Remove this function once tech debt is complete for registrations
  @back_app.business_details_page.submit(
    company_name: business_name,
    postcode: "BS1 5AH",
    result: "ENVIRONMENT AGENCY, HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH"
  )
end

def submit_organisation_details(business_name)
  @journey.company_name_page.submit(company_name: business_name)
  @journey.address_lookup_page.submit_valid_address
end

def old_submit_company_people
  people = @back_app.key_people_page.key_people
  @back_app.key_people_page.add_key_person(person: people[0])
  @back_app.key_people_page.add_key_person(person: people[1])
  @back_app.key_people_page.submit_key_person(person: people[2])
end

def submit_company_people
  # Consider adding an argument to specify how many people are added here, and vary it
  people = @journey.company_people_page.main_people
  @journey.company_people_page.add_main_person(person: people[0])
  @journey.company_people_page.add_main_person(person: people[1])
  @journey.company_people_page.submit_main_person(person: people[2])
end

def old_submit_convictions(convictions)
  if convictions == "no convictions"
    @back_app.relevant_convictions_page.submit(choice: :no)
  else
    puts "Need steps to declare a conviction on old app here"
  end
end

def submit_convictions(convictions)
  if convictions == "no convictions"
    @journey.conviction_declare_page.submit(choice: :no)
  else
    @journey.conviction_declare_page.submit(choice: :yes)
    people = @bo.conviction_details_page.main_people
    @bo.conviction_details_page.submit(person: people[0])
  end
end

def old_submit_contact_details_from_bo
  @back_app.contact_details_page.submit(
    first_name: "Bob",
    last_name: "Carolgees",
    phone_number: "0117 4960000" # fake number from Ofcom site
  )
  @back_app.postal_address_page.submit
  # Back office doesn't have the ability to add a contact address for assisted digital renewals
end

def submit_contact_details_from_bo
  # For a renewal, all tests currently select existing contact details.
  # When registrations have moved to the new app, this function will also need to enter new details.
  @journey.contact_name_page.submit
  @journey.contact_phone_page.submit
  @journey.contact_email_page.submit(
    email: "bo-user@example.com",
    confirm_email: "bo-user@example.com"
  )
  @journey.address_lookup_page.submit_invalid_address
  @journey.address_manual_page.submit(
    house_number: "1",
    address_line_one: "Test lane",
    address_line_two: "Testville",
    city: "Teston"
  )
end

def old_check_your_answers
  @back_app.check_details_page.submit
end

def check_your_answers
  @journey.check_your_answers_page.submit
  @journey.declaration_page.submit
end

def old_order_copy_cards(number_of_cards)
  @back_app.order_page.submit(
    copy_card_number: number_of_cards,
    choice: :card_payment
  )
end

def order_copy_cards(number_of_cards)
  @bo.registration_cards_page.submit(cards: number_of_cards)
end

def old_complete_registration_from_bo(business, tier, carrier)
  expect(@back_app.finish_assisted_page.registration_number).to have_text("CBDU")
  expect(@back_app.finish_assisted_page).to have_view_certificate
  # Stores registration number and access code for later use
  @registration_number = @back_app.finish_assisted_page.registration_number.text
  puts "Registration " + @registration_number + " completed for " + tier + " tier " + business + " " + carrier
  @registration_number
end

def sign_in_to_back_office
  visit((Quke::Quke.config.custom["urls"]["back_office_renewals"]) + "/bo")
  heading = @journey.standard_page.heading.text

  # Bypass if already logged in:
  return unless heading == "Sign in"

  @bo.sign_in_page.submit(
    email: Quke::Quke.config.custom["accounts"]["agency_user"]["username"],
    password: ENV["WCRS_DEFAULT_PASSWORD"]
  )
end

def check_registration_details(reg)
  find_link("Registrations search").click
  @bo.dashboard_page.view_reg_details(search_term: reg)
  expect(@bo.registration_details_page.heading).to have_text("Registration " + reg)
end
