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

def old_submit_organisation_details(business_name)
  # Remove this function once tech debt is complete for registrations
  @old.business_details_page.submit(
    company_name: business_name,
    postcode: "BS1 5AH",
    result: "HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH"
  )
end

def old_submit_company_people(business)
  people = @old.key_people_page.key_people
  @old.key_people_page.add_key_person(person: people[0]) if business == "partnership"
  @old.key_people_page.submit_key_person(person: people[1])
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

def old_submit_contact_details_from_bo
  @old.contact_details_page.submit(
    first_name: "Bob",
    last_name: "Carolgees",
    phone_number: "0117 4960000" # fake number from Ofcom site
  )
  @old.postal_address_page.submit
  # Back office doesn't have the ability to add a contact address for assisted digital renewals
end

def old_check_your_answers
  @old.check_details_page.submit
end

def old_order_cards_during_journey(number_of_cards)
  @old.old_order_page.submit(
    copy_card_number: number_of_cards,
    choice: :card_payment
  )
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
