def start_internal_registration(app)
  if app == "old"
    @back_app.registrations_page.new_registration.click
    @back_app.start_page.submit
    expect(@back_app.location_page.heading).to have_text("Where is your principal place of business?")
    @back_app.location_page.submit(choice: :england)
  else
    puts "New registration journey hasn't been built yet"
  end
end

def submit_carrier_details(app, business, tier, carrier)
  if app == "old"
    if tier == "upper"
      # Consider randomising how 'upper tier' is achieved here
      @back_app.business_type_page.submit(org_type: business)
      @back_app.other_businesses_question_page.submit(choice: :no)
      @back_app.construction_waste_question_page.submit(choice: :yes)
      @back_app.registration_type_page.submit(choice: carrier.to_sym)
    else
      puts "Put old app lower tier steps here"
    end
  else
    puts "Put renewal carrier questions here"
    # Allow option: if any details are "existing" then use what came before - eg "I know I need an upper tier reg"
  end
  business_name = submit_business_details(app, business)
  business_name
end

def submit_business_details(app, business)
  if app == "old"
    if business == "limitedCompany"
      business_name = "AD UT Company limited"
      submit_old_limited_company_details(business_name)
    else
      business_name = "AD UT Organisation limited"
      submit_old_organisation_details(business_name)
    end
  else
    puts "Put renewal carrier questions here"
    # Remember to get the business name here so it can be used in future tests
  end
  business_name
end

def submit_old_limited_company_details(business_name)
  @back_app.business_details_page.submit(
    companies_house_number: "00445790",
    company_name: business_name,
    postcode: "BS1 5AH",
    result: "ENVIRONMENT AGENCY, HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH"
  )
end

def submit_old_organisation_details(business_name)
  @back_app.business_details_page.submit(
    company_name: business_name,
    postcode: "BS1 5AH",
    result: "ENVIRONMENT AGENCY, HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH"
  )
end

def submit_contact_details(app)
  if app == "old"
    @back_app.contact_details_page.submit(
      first_name: "Bob",
      last_name: "Carolgees",
      phone_number: "012345678"
    )
    @back_app.postal_address_page.submit
  else
    puts "Put new app contact details steps here"
  end
end

def submit_key_people(app, business)
  if app == "old"
    people = @back_app.key_people_page.key_people
    @back_app.key_people_page.add_key_person(person: people[0])
    @back_app.key_people_page.add_key_person(person: people[1])
    @back_app.key_people_page.submit_key_person(person: people[2])
  else
    puts "Put renewals 'key people' steps here for " + business
  end
end

def submit_convictions(app, convictions)
  conviction_choice = if convictions == "no convictions"
                        :no
                      else
                        :yes
                      end
  @back_app.relevant_convictions_page.submit(choice: conviction_choice) if app == "old"
end

def check_your_answers(app)
  if app == "old"
    @back_app.check_details_page.submit if app == "old"
  else
    puts "put renewal check your answers steps here"
  end
end

def order_copy_cards(app, number_of_cards)
  if app == "old"
    @back_app.order_page.submit(
      copy_card_number: number_of_cards,
      choice: :card_payment
    )
  else
    puts "Put renewal copy card steps here"
  end
end

def complete_internal_registration(app, business, tier, carrier)
  if app == "old"
    expect(@back_app.finish_assisted_page.registration_number).to have_text("CBDU")
    expect(@back_app.finish_assisted_page).to have_view_certificate
    # Stores registration number and access code for later use
    @registration_number = @back_app.finish_assisted_page.registration_number.text
    puts "Registration " + @registration_number + " completed for " + tier + " tier " + business + " " + carrier
  else
    puts "New registration journey hasn't been built yet"
  end
  @registration_number
end

def sign_in_to_back_office
  visit((Quke::Quke.config.custom["urls"]["back_office_renewals"]) + "/bo")
  expect(@journey_app.standard_page.heading).to have_text "Sign in"
  @bo.sign_in_page.submit(
    email: Quke::Quke.config.custom["accounts"]["agency_user"]["username"],
    password: ENV["WCRS_DEFAULT_PASSWORD"]
  )
end

def check_registration_details(reg)
  find_link("Registrations search").click
  @bo.renewals_dashboard_page.view_reg_details(search_term: reg)
  expect(@bo.registration_details_page.heading).to have_text("Registration " + reg)
end
