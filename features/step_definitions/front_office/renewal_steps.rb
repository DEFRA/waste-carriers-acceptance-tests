Given(/^I renew my last registration$/) do
  @renewals_app = RenewalsApp.new
  @journey = JourneyApp.new
  @renewals_app.old_start_page.load
  @renewals_app.old_start_page.submit(renewal: true)
  @renewals_app.existing_registration_page.submit(reg_no: @reg_number)
end

Given("I receive an email from NCCC inviting me to renew") do
  send_renewal_email(@reg_number)
  expect(@bo.registration_details_page.flash_message).to have_text("Renewal email sent to " + @email_address)

  visit(Quke::Quke.config.custom["urls"]["last_email_bo"])
  renewal_email_text = retrieve_email_containing(["Renew waste carrier registration " + @reg_number])
  # rubocop:disable Style/RedundantRegexpEscape
  @renew_from_email_link = renewal_email_text.match(/.*few minutes at: <a href\=(.*)>http.*/)[1]
  # rubocop:enable Style/RedundantRegexpEscape
  puts "Link to renew " + @reg_number + " is: " + @renew_from_email_link
end

When("I renew from the email as a {string}") do |business_type|
  visit(@renew_from_email_link)
  expect(@renewals_app.renewal_start_page.heading).to have_text("You are about to renew registration " + @reg_number)

  step("I complete my '#{business_type}' renewal steps")

end

When("I incorrectly paste its renewal link") do
  # Omit the final character from the renewal link
  visit(renewal_magic_link_for(@reg_number)[0...-1])
end

Given("I have a registration which expired {int} days ago") do |days_ago|
  load_all_apps
  @tier = "upper"
  new_expiry_date = (DateTime.now - days_ago).to_s

  seed_data = SeedData.new("limitedCompany_expired_registration.json", "expires_on" => new_expiry_date)

  @reg_number = seed_data.reg_number
  @seeded_data = seed_data.seeded_data

  @email_address = @seeded_data["contactEmail"]

  puts "limitedCompany upper tier expired registration " + @reg_number + " seeded"
end

When("I call NCCC to renew it") do
  # Don't need any code here
end

Then("NCCC are unable to generate a renewal email") do
  sign_in_to_back_office("agency-user", false)
  visit_registration_details_page(@reg_number)
  expect(@bo.registration_details_page).to have_no_resend_renewal_email_link
end

Then("I cannot renew again with the same link") do
  visit(@renew_from_email_link)
  expect(@renewals_app.renewal_start_page.heading).to have_text("That registration has already been renewed")
  expect(@renewals_app.renewal_start_page.content).to have_text("Our records show that registration " + @reg_number + " has already been renewed.")
end

Then("I am told the renewal cannot be found") do
  expect(@renewals_app.renewal_start_page.heading).to have_text("We cannot find that renewal")
end

Then(/^I will be shown the renewal information page$/) do
  expect(@renewals_app.renewal_start_page).to have_text(@reg_number)
  expect(@renewals_app.renewal_start_page.current_url).to include "/renewal-information"
end

Then(/^I will be shown the renewal start page$/) do
  @renewals_app.renewal_start_page.wait_until_heading_visible
  expect(@renewals_app.renewal_start_page).to have_text(@reg_number)
  expect(@renewals_app.renewal_start_page.current_url).to include "/renew/CBDU"
end

When(/^I choose to renew my registration from my registrations list$/) do
  @renewals_app.waste_carrier_registrations_page.wait_until_sign_out_visible
  @renewals_app.waste_carrier_registrations_page.registrations[0].renew_registration.click
end

Given(/^I choose to renew my registration$/) do
  Capybara.reset_session!
  @renewals_app = RenewalsApp.new
  @journey = JourneyApp.new
  @renewals_app.old_start_page.load
  @renewals_app.old_start_page.submit(renewal: true)
  @renewals_app.existing_registration_page.submit(reg_no: @reg_number)
end

When(/^I enter my lower tier registration number "([^"]*)"$/) do |reg_no|
  @renewals_app.existing_registration_page.submit(reg_no: reg_no)
end

Then(/^I'm informed "([^"]*)"$/) do |error_message|
  expect(@renewals_app.existing_registration_page.error_message.text).to eq(error_message)
end

Given("I am told that my registration does not expire") do
  expect(page).to have_text("This is a lower tier registration so never expires. Call our helpline on 03708 506506 if you think this is incorrect.")
end

When(/^the organisation type is changed to sole trader$/) do
  agree_to_renew_in_england
  @journey.confirm_business_type_page.submit(org_type: "soleTrader")
end

Then(/^I'm informed I'll need to apply for a new registration$/) do
  expect(@renewals_app.type_change_page).to have_text("You cannot renew")
end

Then(/^I will be informed my renewal is received$/) do
  expect(@renewals_app.renewal_received_page).to have_text("Renewal received")
  expect(@renewals_app.renewal_received_page).to have_text(@reg_number)
end

When(/^I change my carrier broker dealer type to "([^"]*)"$/) do |registration_type|
  agree_to_renew_in_england
  @journey.confirm_business_type_page.submit
  @journey.tier_check_page.submit(choice: :check_tier)
  select_random_upper_tier_options(registration_type.to_sym)
end

When(/^I answer questions indicating I should be a lower tier waste carrier$/) do
  agree_to_renew_in_england
  @journey.confirm_business_type_page.submit
  @journey.tier_check_page.submit(choice: :check_tier)
  @journey.tier_other_businesses_page.submit(choice: :yes)
  @journey.tier_service_provided_page.submit(choice: :main_service)
  @renewals_app.waste_types_page.submit(choice: :yes_only)
end

Given(/^I have signed in to renew my registration as "([^"]*)"$/) do |username|
  @renewals_app = RenewalsApp.new
  @journey = JourneyApp.new
  @renewals_app.waste_carrier_sign_in_page.submit(
    email: username,
    password: ENV["WCRS_DEFAULT_PASSWORD"]
  )
  @email_address = username
end

Given(/^I have signed in to view my registrations as "([^"]*)"$/) do |username|
  @front_app = FrontOfficeApp.new
  @journey = JourneyApp.new
  @front_app.waste_carrier_sign_in_page.load
  @front_app.waste_carrier_sign_in_page.submit(
    email: username,
    password: ENV["WCRS_DEFAULT_PASSWORD"]
  )
end

Given(/^I choose to renew my last registration from the dashboard$/) do
  @renewals_app = RenewalsApp.new
  @journey = JourneyApp.new

  @front_app.waste_carrier_registrations_page.find_registration(@reg_number)
  @front_app.waste_carrier_registrations_page.renew(@reg_number)
end

Given(/^I change the business type to "([^"]*)"$/) do |org_type|
  agree_to_renew_in_england
  @journey.confirm_business_type_page.submit(org_type: org_type)
end

Given(/^I change my place of business location to "([^"]*)"$/) do |location|
  @renewals_app.renewal_start_page.submit
  @journey.location_page.submit(choice: location.to_sym)
end

Then(/^I will be able to continue my renewal$/) do
  @journey.tier_check_page.wait_until_check_tier_visible
  expect(@journey.tier_check_page.current_url).to include "/tier-check"
  Capybara.reset_session!
end

When("I complete my {string} renewal steps") do |business_type|
  # business_type must match the options in page_objects/front_office/registrations/business_type_page.rb
  @business_name ||= business_type + " renewal"
  agree_to_renew_in_england
  @journey.confirm_business_type_page.submit
  @journey.tier_check_page.submit(choice: :check_tier)
  select_random_upper_tier_options("existing")
  @renewals_app.renewal_information_page.submit
  submit_business_details(@business_name)
  submit_company_people
  submit_convictions("no convictions")
  submit_existing_contact_details
  check_your_answers
  @journey.registration_cards_page.submit
  @journey.payment_summary_page.submit(choice: :card_payment)
  submit_valid_card_payment
end

When(/^I complete my limited liability partnership renewal steps choosing to pay by bank transfer$/) do
  @business_name = "LLP renewal via bank transfer"
  agree_to_renew_in_england
  @journey.confirm_business_type_page.submit
  @journey.tier_check_page.submit(choice: :check_tier)
  select_random_upper_tier_options("existing")
  @renewals_app.renewal_information_page.submit
  submit_business_details(@business_name)
  submit_company_people
  submit_convictions("no convictions")
  submit_existing_contact_details
  check_your_answers
  @journey.registration_cards_page.submit
  @journey.payment_summary_page.submit(choice: :bank_transfer_payment)
  @renewals_app.bank_transfer_page.submit
end

When(/^I add two partners to my renewal$/) do
  @business_name = "Partnership renewal"
  agree_to_renew_in_england
  @journey.confirm_business_type_page.submit
  @journey.tier_check_page.submit(choice: :check_tier)
  select_random_upper_tier_options("existing")
  @renewals_app.renewal_information_page.submit
  submit_business_details(@business_name)
  people = @journey.company_people_page.main_people
  @journey.company_people_page.add_main_person(person: people[0])
  @journey.company_people_page.add_main_person(person: people[1])
end

When(/^remove one partner and attempt to continue with my renewal$/) do
  @journey.company_people_page.remove_person[0].click
  @journey.company_people_page.submit_button.click
end

When(/^I complete my overseas company renewal steps$/) do
  @renewals_app.renewal_start_page.submit
  @journey.location_page.submit(choice: :overseas)
  @journey.tier_check_page.submit(choice: :check_tier)
  select_random_upper_tier_options("existing")
  @renewals_app.renewal_information_page.submit
  @journey.company_name_page.submit
  @journey.address_manual_page.submit(
    house_number: "1",
    address_line_one: "Starý Most",
    address_line_two: "River Danube",
    postcode: "811 02", # required, as tests currently fail without a postcode
    city: "Bratislava",
    country: "Slovakia"
  )
  people = @journey.company_people_page.main_people
  @journey.company_people_page.submit_main_person(person: people[0])
  submit_convictions("no convictions")
  @journey.registration_cards_page.submit
  @journey.contact_name_page.submit
  @journey.contact_phone_page.submit
  @journey.contact_email_page.submit
  @journey.address_manual_page.submit(
    house_number: "1",
    address_line_one: "Via poerio",
    address_line_two: "Via Poerio",
    city: "Rome",
    postcode: "00152", # required, as tests currently fail without a postcode
    country: "Italy"
  )
  check_your_answers
  @journey.registration_cards_page.submit
  @journey.payment_summary_page.submit(choice: :card_payment)
  submit_valid_card_payment
end

When(/^I confirm my business type$/) do
  agree_to_renew_in_england
  @journey.confirm_business_type_page.submit
end

Then(/^I will be notified "([^"]*)"$/) do |message|
  expect(@renewals_app.waste_carrier_sign_in_page).to have_text(message)
  Capybara.reset_session!
end

Then(/^I will be asked to add another partner$/) do
  expect(@journey.company_people_page).to have_text("You must add the details of at least 2 people")
  Capybara.reset_session!
end

Then(/^I will be notified my renewal is complete$/) do
  @journey.confirmation_page.wait_until_heading_visible
  expect(@journey.confirmation_page.heading.text).to eq("Renewal complete")
  expect(@journey.confirmation_page).to have_text(@reg_number)

  Capybara.reset_session!
end

Then("I am notified that my renewal payment is being processed") do
  expect(page).to have_content("Application received")
  expect(page).to have_content("We are currently processing your payment")

  @reg_number = @journey.confirmation_page.registration_number.text
  find_text = [@reg_number]

  find_text << "Your application to renew waste carriers registration " + @reg_number + " has been received"
  find_text << "We are currently processing your payment"

  visit Quke::Quke.config.custom["urls"]["last_email_fo"]
  email_found = @journey.last_email_page.check_email_for_text(find_text)
  expect(email_found).to eq(true)

  puts "Renewal #{@reg_number} submitted and pending WorldPay"
end

Then(/^I will be advised "([^"]*)"$/) do |message|
  expect(@renewals_app.renewal_information_page).to have_text(message)
  Capybara.reset_session!
end

Then(/^I will be told my registration can not be renewed$/) do
  expect(@renewals_app.unrenewable_page).to have_text("This registration cannot be renewed")
end

When(/^the renewal date is over one month before it is due to expire$/) do
  # No code to write here, step added so the test reads better
end

When(/^the registration is within the expiry grace renewal window$/) do
  # No code to write here, step added so the test reads better
end

Given(/^I change my companies house number to "([^"]*)"$/) do |number|
  agree_to_renew_in_england
  @journey.confirm_business_type_page.submit
  @journey.tier_check_page.submit(choice: :check_tier)
  select_random_upper_tier_options("existing")
  @renewals_app.renewal_information_page.submit
  @journey.company_number_page.submit(companies_house_number: number.to_sym)
end

Then(/^I will be notified my renewal is pending checks$/) do
  @renewals_app.renewal_received_page.wait_until_heading_visible
  expect(@renewals_app.renewal_received_page.heading.text).to eq("Application received")
  expect(@renewals_app.renewal_received_page).to have_text(@reg_number)
  Capybara.reset_session!
end

Then(/^I will be notified my renewal is pending payment$/) do
  @renewals_app.renewal_received_page.wait_until_heading_visible
  expect(@renewals_app.renewal_received_page.heading.text).to eq("Application received")
  expect(@renewals_app.renewal_received_page).to have_text("pay the renewal charge")
  expect(@renewals_app.renewal_received_page).to have_text(@reg_number)
  Capybara.reset_session!
end

When(/^I try to renew anyway by guessing the renewal url for "([^"]*)"$/) do |reg_no|
  @renewals_app = RenewalsApp.new
  @journey = JourneyApp.new
  renewal_url = Quke::Quke.config.custom["urls"]["front_office"] + "/#{reg_no}/renew"

  visit(renewal_url)
end

Then(/^I will be prompted to sign in to complete the renewal$/) do
  @renewals_app.waste_carriers_renewals_sign_in_page.wait_until_email_address_visible
  expect(@renewals_app.waste_carriers_renewals_sign_in_page.current_url).to include "/users/sign_in"
end
