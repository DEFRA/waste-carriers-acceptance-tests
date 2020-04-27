# Group pieces together when they are always consecutive (renewal - new lower tier - new upper tier)
# Helpers vs Step to group things together - Choose helpers, avoid steps.
# Helpers vs Step - repeat helpers, not steps.
# Use `Given` to set up instance variables for the rest of the journey decisions

Given("I want to register as a lower tier carrier") do
  load_all_apps

  @resource_object = :new_registration
  @tier = "lower"
end

Given("I want to register as an upper tier carrier") do
  load_all_apps

  @resource_object = :new_registration
  @tier = "upper"
end

When("I start a new registration journey in {string} as a {string}") do |location, organisation_type|
  @organisation_type = organisation_type

  @journey.start_page.load
  @journey.start_page.submit

  @journey.location_page.submit(choice: location)

  @journey.business_type_page.submit(org_type: organisation_type)
end

# Main step for generating a new registration.
# It depends on instance variables to decide what to register.
When("I complete my registration") do
  if @organisation_type == "charity"
    # then all tier routing questions are skipped and user is told "you need to register as a lower tier waste carrier"
    @journey.standard_page.submit
  elsif @tier == "lower"
    select_random_lower_tier_options
  else
    select_random_upper_tier_options("existing")
  end

  if @tier == "upper"
    @journey.carrier_type_page.submit(choice: :carrier_broker_dealer)
    @carrier = "carrier_broker_dealer"

    if @organisation_type == "limitedCompany"
      @companies_house_number ||= "00445790"
      @journey.company_number_page.submit(companies_house_number: @companies_house_number)
    end
  end

  @business_name ||= "#{@tier} tier #{@organisation_type} new registration"
  @journey.company_name_page.submit(company_name: @business_name)

  @journey.address_lookup_page.submit_valid_address

  if @tier == "upper"
    @people ||= @journey.company_people_page.main_people

    if @organisation_type == "partnership"
      @journey.company_people_page.add_main_person(person: @people[0])
      @journey.company_people_page.submit_main_person(person: @people[1])
    else
      @journey.company_people_page.submit_main_person(person: @people[0])
    end

    @declared_convictions ||= :no
    @journey.conviction_declare_page.submit(choice: @declared_convictions)
    @relevant_people = @back_app.relevant_people_page.relevant_people
    @journey.conviction_details_page.submit(person: @relevant_people[0]) if @declared_convictions == :yes
  end

  names = {
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name
  }
  @journey.contact_name_page.submit(names)

  @journey.contact_phone_page.submit(phone_number: "0117 4960000")

  @email_address = generate_email
  @journey.contact_email_page.submit(email: @email_address, confirm_email: @email_address)

  @journey.address_lookup_page.submit_valid_address

  expect(page).to have_content("Check your answers")
  @journey.standard_page.submit

  @journey.declaration_page.submit

  @copy_cards ||= 0
  @journey.registration_cards_page.submit(cards: @copy_cards) if @tier == "upper"
end

Then("I am notified that my registration has been successful") do
  expect(page).to have_content("Registration complete")

  @reg_number = @journey.confirmation_page.registration_number.text
  find_text = [@reg_number]

  find_text << "You are now registered as a lower tier" if @tier == "lower"
  find_text << "You are now registered as an upper tier" if @tier == "upper"

  visit Quke::Quke.config.custom["urls"]["last_email_fo"]
  email_found = @journey.last_email_page.check_email_for_text(find_text)
  expect(email_found).to eq(true)

  puts "Registration #{@reg_number} created successfully"
end

Given("a registration with no convictions has been submitted by paying via card") do
  @reg_number = SeedData.seed("complete_active_registration.json")

  puts "Registration " + @reg_number + " seeded"
end

Given(/a registration with outstanding balance and (\d+) copy cards? has been submitted$/) do |copy_cards|
  # Store variables for later steps:
  @copy_cards = copy_cards
  @reg_balance = 154 + 5 * copy_cards

  step("I want to register as an upper tier carrier")
  step("I start a new registration journey in 'England' as a 'soleTrader'")
  step("I complete my registration")
  step("I pay by bank transfer")

  @reg_number = @journey.confirmation_page.registration_number.text
  puts "Registration " + @reg_number + " submitted with #{copy_cards} copy cards and outstanding balance"
end

Given("a limited company with companies house number {string} is registered as an upper tier waste carrier") do |ch_no|
  # Store variables for later steps:
  @business_name = "AD UT Company convictions check ltd"
  @companies_house_number = ch_no

  step("I want to register as an upper tier carrier")
  step("I start a new registration journey in 'England' as a 'limitedCompany'")
  step("I complete my registration")
  step("I pay by card")

  @reg_number = @journey.confirmation_page.registration_number.text
  puts "Registration " + @reg_number + " completed with conviction match on company number"
end

Given("a key person with a conviction registers as a sole trader upper tier waste carrier") do
  # Store variables for later steps:
  @business_name = "AD UT Sole Trader"
  @people = @back_app.key_people_page.dodgy_people

  step("I want to register as an upper tier carrier")
  step("I start a new registration journey in 'England' as a 'soleTrader'")
  step("I complete my registration")
  step("I pay by card")

  @reg_number = @journey.confirmation_page.registration_number.text
  puts "Registration " + @reg_number + " completed with conviction match on relevant person"
end

Given("a conviction is declared when registering their partnership for an upper tier waste carrier") do
  # Store variables for later steps:
  @business_name = "AD Upper Tier Partnership"
  @declared_convictions = :yes

  step("I want to register as an upper tier carrier")
  step("I start a new registration journey in 'England' as a 'partnership'")
  step("I complete my registration")
  step("I pay by card")

  @reg_number = @journey.confirmation_page.registration_number.text
  puts "Registration " + @reg_number + " completed with declared convictions"
end

Given("a registration with declared convictions is submitted with outstanding payment") do
  # Store variables for later steps:
  @business_name = "AD Upper Tier Need Payment"
  @declared_convictions = :yes
  @reg_balance = 154

  step("I want to register as an upper tier carrier")
  step("I start a new registration journey in 'England' as a 'soleTrader'")
  step("I complete my registration")
  step("I pay by bank transfer")

  @reg_number = @journey.confirmation_page.registration_number.text
  puts "Registration " + @reg_number + " submitted with declared convictions and outstanding payment"
end

Given("a limited company {string} registers as an upper tier waste carrier") do |business_name|
  # Store variables for later steps:
  @business_name = business_name

  step("I want to register as an upper tier carrier")
  step("I start a new registration journey in 'England' as a 'limitedCompany'")
  step("I complete my registration")
  step("I pay by card")

  @reg_number = @journey.confirmation_page.registration_number.text
  puts "Registration " + @reg_number + " completed with conviction match on company name"
end
