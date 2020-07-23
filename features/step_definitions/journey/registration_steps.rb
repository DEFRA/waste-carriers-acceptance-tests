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
  @journey.start_page.submit(choice: @resource_object)
  @journey.location_page.submit(choice: location)
  @journey.business_type_page.submit(org_type: organisation_type)
end

# Main step for generating a new registration.
# It depends on instance variables to decide what to register:

When("I complete my registration for my business {string}") do |business_name|
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

    if @organisation_type == "limitedCompany" || @organisation_type == "limitedLiabilityPartnership"
      @companies_house_number ||= "00445790"
      @journey.company_number_page.submit(companies_house_number: @companies_house_number)
    end
  end

  @business_name = business_name
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
  order_cards_during_journey(@copy_cards) if @tier == "upper"
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

Then("I am notified that I need to pay by bank transfer") do
  expect(page).to have_content("You must now pay by bank transfer")
  expect(page).to have_content("We’ve sent an email to " + @email_address + " with the payment details and instructions.")

  @reg_number = @journey.confirmation_page.registration_number.text
  find_text = [@reg_number]

  find_text << "You need to pay for your waste carriers registration and then email us to confirm payment"
  find_text << "Email us your registration " + @reg_number + " to confirm you’ve paid"

  visit Quke::Quke.config.custom["urls"]["last_email_fo"]
  email_found = @journey.last_email_page.check_email_for_text(find_text)
  expect(email_found).to eq(true)

  puts "Registration #{@reg_number} submitted pending bank transfer"
end

Then("I am notified that my registration payment is being processed") do
  expect(page).to have_content("We’re processing your payment")

  @reg_number = @journey.confirmation_page.registration_number.text
  find_text = [@reg_number]

  find_text << "We’re processing your waste carrier registration"
  find_text << "We’re currently processing your payment"

  visit Quke::Quke.config.custom["urls"]["last_email_fo"]
  email_found = @journey.last_email_page.check_email_for_text(find_text)
  expect(email_found).to eq(true)

  puts "Registration #{@reg_number} submitted and pending WorldPay"
end

Given("a registration with no convictions has been submitted by paying via card") do
  seed_data = SeedData.new("limitedCompany_complete_active_registration.json")
  @reg_number = seed_data.reg_number
  @seeded_data = seed_data.seeded_data

  puts "Registration " + @reg_number + " seeded"
end

Given("I create a new registration as {string}") do |account_email|
  load_all_apps
  @tier = "upper"
  seed_data = SeedData.new("limitedCompany_complete_active_registration.json", "accountEmail" => account_email)
  @reg_number = seed_data.reg_number
  @seeded_data = seed_data.seeded_data
  @email_address = account_email

  puts "Registration " + @reg_number + " seeded"
end

Given("I create an upper tier registration for my {string} business as {string}") do |business_type, account_email|
  load_all_apps
  @tier = "upper"
  seed_data = SeedData.new("#{business_type}_complete_active_registration.json", "accountEmail" => account_email, "contactEmail" => account_email)
  @reg_number = seed_data.reg_number
  @email_address = account_email
  @seeded_data = seed_data.seeded_data

  puts "#{business_type} upper tier registration " + @reg_number + " seeded"
end

Given("I create a lower tier registration for my {string} business as {string}") do |business_type, account_email|
  @tier = "lower"
  seed_data = SeedData.new("lower_#{business_type}_complete_active_registration.json", "accountEmail" => account_email)
  @reg_number = seed_data.reg_number
  @email_address = account_email
  @seeded_data = seed_data.seeded_data

  puts "#{business_type} lower tier registration " + @reg_number + " seeded for " + account_email
end

Given("I have a new registration for a {string} business") do |business_type|
  @tier = "upper"
  seed_data = SeedData.new("#{business_type}_complete_active_registration.json")
  @reg_number = seed_data.reg_number
  @seeded_data = seed_data.seeded_data

  puts "#{business_type} registration " + @reg_number + " seeded"
end

Given("I have a new lower tier registration for a {string} business") do |business_type|
  load_all_apps
  @tier = "lower"
  @business_name = "Lower tier public body seed"
  seed_data = SeedData.new("lower_#{business_type}_complete_active_registration.json", "companyName" => @business_name)
  @reg_number = seed_data.reg_number
  @seeded_data = seed_data.seeded_data

  puts "#{business_type} lower tier registration " + @reg_number + " seeded"
end

Given("I create a new registration as {string} with a company name of {string}") do |account_email, company_name|
  load_all_apps
  @email_address = account_email
  @business_name = company_name
  seed_data = SeedData.new(
    "limitedCompany_complete_active_registration.json",
    "accountEmail" => @email_address,
    "contactEmail" => @email_address,
    "companyName" => @business_name
  )
  @reg_number = seed_data.reg_number
  @seeded_data = seed_data.seeded_data
  @tier = "upper"
  @resource_object = :registration

  puts "Registration " + @reg_number + " seeded with name #{@business_name} for " + @email_address
end

Given("I have an active registration") do
  load_all_apps
  account_email = Quke::Quke.config.custom["accounts"]["waste_carrier2"]["username"]

  seed_data = SeedData.new("limitedCompany_complete_active_registration.json", "accountEmail" => account_email)
  @reg_number = seed_data.reg_number
  @seeded_data = seed_data.seeded_data
  @reg_balance = 0

  puts "Registration " + @reg_number + " seeded for " + account_email
end

Given("I have an active registration with a company number of {string}") do |company_no|
  load_all_apps
  seed_data = SeedData.new("limitedCompany_complete_active_registration.json", "company_no" => company_no)
  @reg_number = seed_data.reg_number
  @seeded_data = seed_data.seeded_data

  puts "Registration " + @reg_number + " seeded with company number of #{company_no}"
end

Given("I have an active registration with a company name of {string}") do |company_name|
  load_all_apps
  seed_data = SeedData.new("limitedCompany_complete_active_registration.json", "companyName" => company_name)
  @email_address = "user@example.com"
  @reg_number = seed_data.reg_number
  @seeded_data = seed_data.seeded_data
  @business_name = company_name
  @tier = "upper"
  @resource_object = :registration

  puts "Registration " + @reg_number + " seeded with company name of #{company_name}"
end

Given(/a registration with outstanding balance and (\d+) copy cards? has been submitted$/) do |copy_cards|
  # Store variables for later steps:
  @copy_cards = copy_cards
  @reg_balance = 154 + 5 * copy_cards
  @business_name = "Outstanding Balance Limited"

  seed_data = SeedData.new("outstanding_balance_pending_registration.json", copy_cards: copy_cards)
  @reg_number = seed_data.reg_number
  @seeded_data = seed_data.seeded_data

  puts "Registration " + @reg_number + " seeded with #{copy_cards} copy cards and outstanding balance"
end

Given("a registration with outstanding convictions checks has been submitted") do
  seed_data = SeedData.new("outstanding_convictions_checks_registration.json")
  @reg_number = seed_data.reg_number
  @seeded_data = seed_data.seeded_data

  puts "Registration " + @reg_number + " seeded with outstanding conviction checks"
end

Given("a limited company with companies house number {string} is registered as an upper tier waste carrier") do |ch_no|
  # We recommend you don't reuse this scenario as it relies on creating a fresh registration with convictions,
  # which will slow down tests.
  # If you need registration data then use the seed functionality instead, as described in the README.

  # Store variables for later steps:
  @business_name = "AD UT Company convictions check ltd"
  @companies_house_number = ch_no

  step("I want to register as an upper tier carrier")
  step("I start a new registration journey in 'England' as a 'limitedCompany'")
  step("I complete my registration for my business '#{@business_name}'")
  step("I pay by card")

  @reg_number = @journey.confirmation_page.registration_number.text
  puts "Registration " + @reg_number + " completed with conviction match on company number"
end

Given("a key person with a conviction registers as a sole trader upper tier waste carrier") do
  # We recommend you don't reuse this scenario as it relies on creating a fresh registration with convictions,
  # which will slow down tests.
  # If you need registration data then use the seed functionality instead, as described in the README.

  # Store variables for later steps:
  @business_name = "AD UT Sole Trader"
  @people = dodgy_people

  step("I want to register as an upper tier carrier")
  step("I start a new registration journey in 'England' as a 'soleTrader'")
  step("I complete my registration for my business '#{@business_name}'")
  step("I pay by card")

  @reg_number = @journey.confirmation_page.registration_number.text
  puts "Registration " + @reg_number + " completed with conviction match on relevant person"
end

Given("a conviction is declared when registering their partnership for an upper tier waste carrier") do
  # We recommend you don't reuse this scenario as it relies on creating a fresh registration with convictions,
  # which will slow down tests.
  # If you need registration data then use the seed functionality instead, as described in the README.

  # Store variables for later steps:
  @business_name = "AD Upper Tier Partnership"
  @declared_convictions = :yes

  step("I want to register as an upper tier carrier")
  step("I start a new registration journey in 'England' as a 'partnership'")
  step("I complete my registration for my business '#{@business_name}'")
  step("I pay by card")

  @reg_number = @journey.confirmation_page.registration_number.text
  puts "Registration " + @reg_number + " completed with declared convictions"
end

Given("a registration with declared convictions is submitted with outstanding payment") do
  # We recommend you don't reuse this scenario as it relies on creating a fresh registration with convictions,
  # which will slow down tests.
  # If you need registration data then use the seed functionality instead, as described in the README.

  # Store variables for later steps:
  @business_name = "AD Upper Tier Need Payment"
  @declared_convictions = :yes
  @reg_balance = 154

  step("I want to register as an upper tier carrier")
  step("I start a new registration journey in 'England' as a 'soleTrader'")
  step("I complete my registration for my business '#{@business_name}'")
  step("I pay by bank transfer")

  @reg_number = @journey.confirmation_page.registration_number.text
  puts "Registration " + @reg_number + " submitted with declared convictions and outstanding payment"
end

Given("I have a pending registration") do
  seed_data = SeedData.new("outstanding_balance_pending_registration.json")
  @pending_reg_number = seed_data.reg_number

  puts "Pending registration " + @pending_reg_number + " seeded"
end

Given("a limited company {string} registers as an upper tier waste carrier") do |business_name|
  # We recommend you don't reuse this scenario as it relies on creating a fresh registration with convictions,
  # which will slow down tests.
  # If you need registration data then use the seed functionality instead, as described in the README.

  # Store variables for later steps:
  @business_name = business_name

  step("I want to register as an upper tier carrier")
  step("I start a new registration journey in 'England' as a 'limitedCompany'")
  step("I complete my registration for my business '#{@business_name}'")
  step("I pay by card")

  @reg_number = @journey.confirmation_page.registration_number.text
  puts "Registration " + @reg_number + " completed with conviction match on company name"
end

Given("I get part way through a front office registration") do
  step("I start a new registration journey in 'England' as a 'limitedLiabilityPartnership'")

  @business_name = "Resume registration " + rand(1..999_999).to_s
  select_random_upper_tier_options("existing")
  @journey.carrier_type_page.submit(choice: :carrier_broker_dealer)
  @carrier = "carrier_broker_dealer"
  @companies_house_number ||= "00445790"
  @journey.company_number_page.submit(companies_house_number: @companies_house_number)
  @journey.company_name_page.submit(company_name: @business_name)
  @journey.address_lookup_page.submit_valid_address
  @people = @journey.company_people_page.main_people
  @journey.company_people_page.submit_main_person(person: @people[0])
  @journey.conviction_declare_page.submit(choice: :no)
  @journey.contact_name_page.submit(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name
  )
  @journey.contact_phone_page.submit(phone_number: "0117 4960000")
end

Given("the in-progress registration details are correct") do
  @bo.dashboard_page.view_new_reg_details(search_term: @business_name)
  expect(@bo.registration_details_page.heading).to have_text("New registration for " + @business_name)
  expect(@bo.registration_details_page.info_panel).to have_text("Carrier, broker and dealer")
  expect(@bo.registration_details_page.content).to have_text(@people[0][:first_name] + " " + @people[0][:last_name])
end

Given("I resume the registration as assisted digital") do
  @bo.registration_details_page.continue_as_ad_button.click
  @bo.ad_privacy_policy_page.submit_button.click

  # Continue the journey where the previous user left off
  expect(@journey.contact_email_page.heading).to have_text("contact email address?")
  @email_address = generate_email
  @journey.contact_email_page.submit(email: @email_address, confirm_email: @email_address)
  @journey.address_lookup_page.submit_valid_address
  expect(page).to have_content("Check your answers")
  @journey.standard_page.submit
  @journey.declaration_page.submit
  order_cards_during_journey(3)
  @journey.payment_summary_page.submit(
    choice: :card_payment,
    email: @email_address
  )
  submit_valid_card_payment
  expect(@journey.confirmation_page.heading).to have_text("Registration complete")
  @reg_number = @journey.confirmation_page.registration_number.text
end
