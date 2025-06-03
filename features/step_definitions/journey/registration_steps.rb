Given("I want to register as a lower tier carrier") do
  load_all_apps
  @reg_type = :new_registration
  @tier = :lower
  @app = :fo
  @journey.start_page.load
  @journey.standard_page.accept_cookies
end

Given("I want to register as an upper tier carrier") do
  load_all_apps

  @reg_type = :new_registration
  @app = :fo
  @tier = :upper
  @journey.start_page.load
  @journey.standard_page.accept_cookies
end

When("I start a new registration journey in {string} as a {string}") do |location, organisation_type|
  @organisation_type = organisation_type.to_sym
  @journey.start_page.submit(choice: @reg_type)
  @journey.location_page.submit(choice: location)
  @journey.standard_page.submit if location == "Northern Ireland"

end

When("I am on the business name page") do
  @journey.confirm_business_type_page.submit(org_type: @organisation_type)
  @journey.check_your_tier_page.submit(option: @tier)
  @journey.carrier_type_page.submit(choice: :carrier_broker_dealer)
  if @tier == :upper && @organisation_type == :partnership
    submit_partners
  else
    submit_company_people
  end
end

Then("I submit the form") do
  @journey.standard_page.submit
end

# Main step for generating a new registration.
# It depends on instance variables to decide what to register:

When("I complete my registration for my business {string}") do |business_name|
  @business_name = business_name
  @carrier ||= :carrier_broker_dealer
  submit_carrier_details(@organisation_type, @tier, @carrier)

  if @tier == :upper && @organisation_type != :partnership && (@journey.company_number_page.heading.has_text? "What's the registration number")
    # then it's a limited company or LLP:
    @companies_house_number = "00445790" if @companies_house_number.nil?
    @journey.company_number_page.submit(companies_house_number: @companies_house_number)
    @journey.check_registered_company_name_page.submit(choice: :confirm)
  end

  if @tier == :upper && @organisation_type == :partnership
    submit_partners
  elsif @tier == :upper
    submit_company_people
  end
  submit_organisation_details(@business_name)
  @convictions ||= "no convictions"
  submit_convictions(@convictions) if @tier == :upper
  @contact_email = generate_email if @contact_email.nil?
  submit_contact_details_for_registration(@contact_email)
  expect(page).to have_content("Check your answers")
  @journey.standard_page.submit
  @journey.declaration_page.submit
  @copy_cards ||= 0
  order_cards_during_journey(@copy_cards) if @tier == :upper
end

Then("I am notified that my registration has been successful") do
  expect(page).to have_content("Registration complete")
  @reg_number = @journey.confirmation_page.registration_number.text
  puts "Registration #{@reg_number} created successfully"
end

Then("I am notified that my registration is processing payment") do
  expect(page).to have_content("We're processing your payment")
  @reg_number = @journey.confirmation_page.registration_number.text
  puts "Registration #{@reg_number} pending payment"
end

Then(/^(?:I will receive a registration confirmation email|a registraton confirmation email will be sent)$/) do
  expected_text = [@reg_number, "Download your certificate"]
  expected_text << "You are now registered as a lower tier" if @tier == :lower
  expected_text << "You are now registered as an upper tier" if @tier == :upper
  expect(message_exists?(expected_text)).to be true
end

Then("a registration received pending payment email will be sent") do
  expected_text = [@reg_number, "We’re processing your payment"]
  expect(message_exists?(expected_text)).to be true
  # resets the default payment status to success
  visit_govpay_mock_payment_status_page("success")
end

Then(/^(?:I will receive a registration confirmation letter|a registraton confirmation letter will be sent)$/) do
  expected_text = [@reg_number, "letter"]
  expected_text << "You are now registered as a lower tier" if @tier == :lower
  expected_text << "You are now registered as an upper tier" if @tier == :upper
  expect(message_exists?(expected_text)).to be true
end

Then("a renewal confirmation letter is sent") do
  expected_text = [@reg_number, "letter", "renewed"]
  expect(message_exists?(expected_text)).to be true
end

Then("an application confirmation email will be sent") do
  expected_text = [@reg_number, "Application received"]
  expect(message_exists?(expected_text)).to be true
end

Then("the registration certificate can be viewed from the email") do
  visit_last_message_page_for(:fo)
  @certificate_link_from_email_link = @journey.last_message_page.get_certificate_url(@reg_number)
  puts "Certificate link for #{@reg_number} is #{@certificate_link_from_email_link}"
  raise("Missing certificate link token") if @certificate_link_from_email_link.nil?

  visit(@certificate_link_from_email_link)
  @journey.standard_page.accept_cookies
  @fo.certificate_confirm_email_page.submit(
    email: @contact_email
  )
  expect(page).to have_content("Certificate of Registration under the Waste (England and Wales) Regulations 2011")
  expect(page).to have_content(@reg_number)
end

Then("I am notified that I need to pay by bank transfer") do
  expect(page).to have_content("You must now pay by bank transfer")
  expect(page).to have_content("We've sent an email to #{@contact_email} with the payment details and instructions.")
  @reg_number = @journey.confirmation_page.registration_number.text
  puts "Registration #{@reg_number} submitted pending bank transfer"
end

Then("I am sent an email advising me how to pay by bank transfer") do
  expected_text = ["Payment needed for waste carrier registration #{@reg_number}"]
  expect(message_exists?(expected_text)).to be true
end

Then("I will be asked to enter a business name") do
  expect(@journey.company_name_page.error_summary).to have_text("Enter a business or trading name")
end

Given("a registration with no convictions has been submitted by paying via card") do
  load_all_apps
  seed_data = SeedData.new("limitedCompany_complete_active_registration.json")
  @reg_number = seed_data.reg_number
  @seeded_data = seed_data.seeded_data
  puts "Registration #{@reg_number} seeded"
end

Given("I create a new registration") do
  load_all_apps
  @tier = :upper
  @organisation_type = :limitedCompany
  seed_data = SeedData.new("limitedCompany_complete_active_registration.json")
  @reg_number = seed_data.reg_number
  @seeded_data = seed_data.seeded_data
  @contact_email = @seeded_data["contactEmail"]
  puts "Registration #{@reg_number} seeded"
end

Given("I have a company registration with an inactive companies house number") do
  load_all_apps
  @tier = :upper
  @organisation_type = :limitedCompany
  seed_data = SeedData.new("limitedCompany_complete_inactive_registration.json")
  @reg_number = seed_data.reg_number
  @seeded_data = seed_data.seeded_data
  @contact_email = @seeded_data["contactEmail"]
  puts "Registration #{@reg_number} seeded"
end

Given("I create an upper tier registration for my {string} business") do |business_type|
  load_all_apps
  @tier = :upper
  new_expiry_date = (DateTime.now + 30).to_s
  @contact_email = "user@example.com"
  seed_data = SeedData.new("#{business_type}_complete_active_registration.json", "expires_on" => new_expiry_date, "contactEmail" => @contact_email)
  @reg_number = seed_data.reg_number
  @seeded_data = seed_data.seeded_data
  @organisation_type = business_type
  puts "#{business_type} upper tier registration #{@reg_number} seeded"
end

Given("I create a lower tier registration for my {string} business") do |business_type|
  load_all_apps
  @tier = :lower
  @deregistration_token = SecureRandom.alphanumeric(24)
  @deregistration_token_created_date = DateTime.now.strftime("%Y-%m-%d")
  seed_data = SeedData.new("lower_#{business_type}_complete_active_registration.json",
                           "deregistration_token" => @deregistration_token,
                           "deregistration_token_created_at" => @deregistration_token_created_date)
  @reg_number = seed_data.reg_number
  @seeded_data = seed_data.seeded_data
  puts "#{business_type} lower tier registration #{@reg_number} seeded"
end

Given("I have a new registration for a {string} business") do |business_type|
  load_all_apps
  @tier = :upper
  seed_data = SeedData.new("#{business_type}_complete_active_registration.json")
  @reg_number = seed_data.reg_number
  @seeded_data = seed_data.seeded_data
  @organisation_type = business_type
  @contact_email = @seeded_data["contactEmail"]
  puts "#{business_type} registration #{@reg_number} seeded"
end

Given("I have a new registration for a {string} with business name {string}") do |business_type, business_name|
  load_all_apps
  @tier = :upper
  seed_data = SeedData.new("#{business_type}_complete_active_registration.json",
                           "companyName" => business_name)
  @reg_number = seed_data.reg_number
  @seeded_data = seed_data.seeded_data
  @organisation_type = business_type
  @contact_email = @seeded_data["contactEmail"]
  @business_name = business_name
  puts "#{business_type} registration #{@reg_number} seeded"
end

Given("I have a new lower tier registration for a {string} business") do |business_type|
  load_all_apps
  @tier = :lower
  @business_name = "Lower tier public body seed"
  seed_data = SeedData.new("lower_#{business_type}_complete_active_registration.json", "companyName" => @business_name)
  @reg_number = seed_data.reg_number
  @seeded_data = seed_data.seeded_data

  puts "#{business_type} lower tier registration #{@reg_number} seeded"
end

Given("I create a new registration with a company name of {string}") do |company_name|
  load_all_apps
  @business_name = company_name
  @organisation_type = :limitedCompany
  seed_data = SeedData.new(
    "limitedCompany_complete_active_registration.json",
    "contactEmail" => Quke::Quke.config.custom["accounts"]["waste_carrier2"]["username"],
    "companyName" => @business_name
  )
  @reg_number = seed_data.reg_number
  @seeded_data = seed_data.seeded_data
  @tier = :upper
  @reg_type = :registration

  puts "Registration #{@reg_number} seeded with name #{@business_name}"
end

Given("I have an active registration") do
  load_all_apps
  @tier = :upper

  seed_data = SeedData.new("limitedCompany_complete_active_registration.json")
  @organisation_type = :limitedCompany
  @tier = :upper
  @reg_number = seed_data.reg_number
  @seeded_data = seed_data.seeded_data
  @reg_balance = 0

  puts "Registration #{@reg_number} seeded"
end

Given("I have a registration ready for a bank transfer refund") do
  load_all_apps
  @tier = :upper

  seed_data = SeedData.new("refund_bacs_payment.json")
  @tier = :upper
  @reg_number = seed_data.reg_number
  @seeded_data = seed_data.seeded_data
  @reg_balance = 0

  puts "Registration #{@reg_number} seeded"
end

Given("I have an active registration with a company number of {string}") do |company_no|
  load_all_apps
  @tier = :upper
  seed_data = SeedData.new("limitedCompany_complete_active_registration.json",
                           "company_no" => company_no)
  @reg_number = seed_data.reg_number
  @seeded_data = seed_data.seeded_data
  @companies_house_number = company_no
  @organisation_type = :limitedCompany

  puts "Registration #{@reg_number} seeded with company number of #{company_no}"
end

Given("I have a new upper tier registration with a pending card payment") do
  load_all_apps
  @tier = :upper
  seed_data = SeedData.new("upper_tier_pending_card_payment_registration.json")
  @seeded_data = seed_data.seeded_data
  @reg_number = seed_data.reg_number
  @contact_email = @seeded_data["contactEmail"]
  puts "Upper tier registration with pending card payment #{@reg_number} seeded"
end

Given("I have an active registration with a company name of {string}") do |company_name|
  load_all_apps
  @tier = :upper
  seed_data = SeedData.new("limitedCompany_complete_active_registration.json",
                           "companyName" => company_name)
  @contact_email = "user@example.com"
  @reg_number = seed_data.reg_number
  @seeded_data = seed_data.seeded_data
  @business_name = company_name
  @reg_type = :registration
  @organisation_type = :limitedCompany
  puts "Registration #{@reg_number} seeded with company name of #{company_name}"
end

Given(/a registration with outstanding balance and (\d+) copy cards? has been submitted$/) do |copy_cards|
  load_all_apps
  # Store variables for later steps:
  @copy_cards = copy_cards
  @reg_balance = 154 + (5 * copy_cards)
  @business_name = "Outstanding Balance Limited"

  seed_data = SeedData.new("outstanding_balance_pending_registration.json", copy_cards: copy_cards)
  @reg_number = seed_data.reg_number
  @seeded_data = seed_data.seeded_data

  puts "Registration #{@reg_number} seeded with #{copy_cards} copy cards and outstanding balance"
end

Given("a registration with outstanding convictions checks has been submitted") do
  seed_data = SeedData.new("outstanding_convictions_checks_registration.json")
  @reg_number = seed_data.reg_number
  @seeded_data = seed_data.seeded_data

  puts "Registration #{@reg_number} seeded with outstanding conviction checks"
end

Given("a limited company with companies house number {string} is registered as an upper tier waste carrier") do |ch_no|
  # We recommend you don't reuse this scenario as it relies on creating a fresh registration with convictions,
  # which will slow down tests.
  # If you need registration data then use the seed functionality instead, as described in the README.

  # Store variables for later steps:
  @business_name = "AD UT Company convictions check ltd"
  @organisation_type = :limitedCompany
  @companies_house_number = ch_no

  step("I want to register as an upper tier carrier")
  @journey.start_page.load
  @journey.standard_page.accept_cookies

  @journey.start_page.submit(choice: @reg_type)
  @journey.location_page.submit(choice: :England)
  step("I complete my registration for my business '#{@business_name}'")
  step("I pay by card")

  @reg_number = @journey.confirmation_page.registration_number.text
  puts "Registration #{@reg_number} completed with conviction match on company number"
end

Given("a key person with a conviction registers as a sole trader upper tier waste carrier") do
  # We recommend you don't reuse this scenario as it relies on creating a fresh registration with convictions,
  # which will slow down tests.
  # If you need registration data then use the seed functionality instead, as described in the README.

  # Store variables for later steps:
  @business_name = "AD UT Sole Trader"
  @people = dodgy_people
  @convictions = "convictions"
  @tier = :upper
  @organisation_type = :soleTrader

  step("I want to register as an upper tier carrier")
  step("I start a new registration journey in 'England' as a 'soleTrader'")
  step("I complete my registration for my business '#{@business_name}'")
  step("I pay by card")

  @reg_number = @journey.confirmation_page.registration_number.text
  puts "Registration #{@reg_number} completed with conviction match on relevant person"
end

Given("a conviction is declared when registering their partnership for an upper tier waste carrier") do
  # We recommend you don't reuse this scenario as it relies on creating a fresh registration with convictions,
  # which will slow down tests.
  # If you need registration data then use the seed functionality instead, as described in the README.

  # Store variables for later steps:
  @business_name = "AD Upper Tier Partnership"
  @convictions = "convictions"

  step("I want to register as an upper tier carrier")
  step("I start a new registration journey in 'England' as a 'partnership'")
  step("I complete my registration for my business '#{@business_name}'")
  step("I pay by card")

  @reg_number = @journey.confirmation_page.registration_number.text
  puts "Registration #{@reg_number} completed with declared convictions"
end

Given("a registration with declared convictions is submitted with outstanding payment") do
  # We recommend you don't reuse this scenario as it relies on creating a fresh registration with convictions,
  # which will slow down tests.
  # If you need registration data then use the seed functionality instead, as described in the README.

  # Store variables for later steps:
  @business_name = "AD Upper Tier Need Payment"
  @convictions = "convictions"
  @reg_balance = 154
  load_all_apps

  step("I want to register as an upper tier carrier")
  step("I start a new registration journey in 'England' as a 'soleTrader'")
  step("I complete my registration for my business '#{@business_name}'")
  step("I pay by bank transfer")

  @reg_number = @journey.confirmation_page.registration_number.text
  puts "Registration #{@reg_number} submitted with declared convictions and outstanding payment"
end

Given("I have a pending registration") do
  seed_data = SeedData.new("outstanding_balance_pending_registration.json")
  @pending_reg_number = seed_data.reg_number

  puts "Pending registration #{@pending_reg_number} seeded"
end

Given("a partnership {string} registers as an upper tier waste carrier") do |business_name|
  # We recommend you don't reuse this scenario as it relies on creating a fresh registration with convictions,
  # which will slow down tests.
  # If you need registration data then use the seed functionality instead, as described in the README.

  # Store variables for later steps:
  @business_name = business_name

  step("I want to register as an upper tier carrier")
  step("I start a new registration journey in 'England' as a 'partnership'")
  step("I complete my registration for my business '#{@business_name}'")
  step("I pay by card")

  @reg_number = @journey.confirmation_page.registration_number.text
  puts "Registration #{@reg_number} completed with conviction match on company name"
end

Given("I get part way through a front office registration") do
  step("I start a new registration journey in 'England' as a 'limitedLiabilityPartnership'")

  @business_name = "Resume registration #{rand(1..999_999)}"
  @journey.confirm_business_type_page.submit(org_type: "limitedLiabilityPartnership")
  select_random_upper_tier_route
  @journey.carrier_type_page.submit(choice: :carrier_broker_dealer)
  @carrier = "carrier_broker_dealer"
  @companies_house_number ||= "00445790"
  @journey.company_number_page.submit(companies_house_number: @companies_house_number)
  @journey.check_registered_company_name_page.submit(choice: :confirm)
  @people = @journey.company_people_page.main_people
  @journey.company_people_page.submit_main_person(person: @people[0])
  @journey.trading_name_question_page.submit(option: :yes)
  @journey.company_name_page.submit(company_name: @business_name)
  @journey.address_lookup_page.submit_valid_address

  @journey.conviction_declare_page.submit(choice: :no)
  @journey.contact_name_page.submit(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name
  )
  @journey.contact_phone_page.submit(phone_number: "0117 4960000")
end

Given("the in-progress registration details are correct") do
  @bo.dashboard_page.view_new_reg_details(search_term: @business_name)
  expect(@bo.registration_details_page.heading).to have_text("New registration for #{@business_name}")
  expect(@bo.registration_details_page.info_panel).to have_text("Carrier, broker and dealer")
  expect(@bo.registration_details_page).to have_text("#{@people[0][:first_name]} #{@people[0][:last_name]}")
end

Given("I resume the registration as assisted digital") do
  @bo.registration_details_page.continue_as_ad_button.click
  @bo.ad_privacy_policy_page.submit_button.click
  @app = :bo

  # Continue the journey where the previous user left off
  expect(@journey.contact_email_page.heading).to have_text("contact email address?")
  @contact_email = generate_email
  @journey.contact_email_page.submit(email: @contact_email, confirm_email: @contact_email)
  @journey.address_reuse_page.submit(choice: :no)
  @journey.address_lookup_page.submit_valid_address
  expect(page).to have_content("Check your answers")
  @journey.standard_page.submit
  @journey.declaration_page.submit
  order_cards_during_journey(3)
  @journey.payment_summary_page.submit(choice: :card_payment)
  @journey.confirm_payment_method_page.submit(choice: :yes)
  submit_card_payment
  expect(@journey.confirmation_page.heading).to have_text("Registration complete")
  @reg_number = @journey.confirmation_page.registration_number.text
  puts "#{@reg_number} resumed and completed as assisted digital"
end

Given("an upper tier {string} registration is completed in the front office") do |organisation_type|
  load_all_apps
  @reg_type = :new_registration
  @app = :fo
  @tier = :upper
  @organisation_type = organisation_type.to_sym
  @app = :fo
  @journey.start_page.load
  @journey.standard_page.accept_cookies
  @journey.start_page.submit(choice: :new_registration)
  @journey.location_page.submit(choice: :England)
  @carrier ||= :carrier_broker_dealer
  submit_carrier_details(@organisation_type, @tier, @carrier)

  if @tier == :upper && @organisation_type != :partnership && (@journey.company_number_page.heading.has_text? "What's the registration number")
    # then it's a limited company or LLP:
    @companies_house_number = "00445790" if @companies_house_number.nil?
    @journey.company_number_page.submit(companies_house_number: @companies_house_number)
    @journey.check_registered_company_name_page.submit(choice: :confirm)
  end

  if @tier == :upper && @organisation_type == :partnership
    submit_partners
  elsif @tier == :upper
    submit_company_people
  end
  submit_organisation_details("Upper tier registration")
  @convictions ||= "no convictions"
  submit_convictions(@convictions) if @tier == :upper
  @contact_email = generate_email if @contact_email.nil?
  submit_contact_details_for_registration(@contact_email)
  expect(page).to have_content("Check your answers")
  @journey.standard_page.submit
  @journey.declaration_page.submit
  @copy_cards ||= 0
  order_cards_during_journey(@copy_cards) if @tier == :upper
  @journey.payment_summary_page.submit(choice: :card_payment)
  @journey.confirm_payment_method_page.submit(choice: :yes)
  submit_card_payment
  @reg_number = @journey.confirmation_page.registration_number.text
  puts "Registration #{@reg_number} created successfully"
end

Given("my princple place of business is in {string}") do |location|
  @journey.start_page.submit(choice: @reg_type)
  @journey.location_page.submit(choice: location)
end

Then("I will be informed {string}") do |message|
  expect(@journey.standard_page).to have_text(message)
end
