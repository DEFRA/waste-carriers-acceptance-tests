Given("I start renewing this registration from the start page") do
  @journey = JourneyApp.new
  @reg_type = :renewal
  @journey.start_page.load
  @journey.standard_page.accept_cookies

  @journey.start_page.submit(choice: @reg_type)
  @journey.existing_registration_page.submit(reg_no: @reg_number)
  @reg_type = :renewal
end

Given("I receive an email from NCCC inviting me to renew") do
  send_renewal_email(@reg_number)
  expect(@bo.registration_details_page.flash_message).to have_text("Renewal email sent to #{@email_address}")
  visit(Quke::Quke.config.custom["urls"]["notify_link"])
  @renew_from_email_link = @journey.last_message_page.get_renewal_url(@reg_number)
  puts "Renewal link for #{@reg_number} is #{@renew_from_email_link}"

end

When("I renew from the email as a {string}") do |business_type|
  visit(@renew_from_email_link)
  expect(@journey.renewal_start_page.heading).to have_text("You are about to renew registration #{@reg_number}")
  @reg_type = :renewal
  @organisation_type = business_type
  @tier = :upper
  step("I complete my '#{business_type}' renewal steps")
end

When("I incorrectly paste its renewal link") do
  # Omit the final character from the renewal link
  visit(renewal_magic_link_for(@reg_number)[0...-1])
end

Given("I have a registration which expired {int} days ago") do |days_ago|
  load_all_apps
  @tier = :upper
  new_expiry_date = (DateTime.now - days_ago).to_s

  seed_data = SeedData.new("limitedCompany_expired_registration.json", "expires_on" => new_expiry_date)
  @reg_number = seed_data.reg_number
  @seeded_data = seed_data.seeded_data
  @email_address = @seeded_data["contactEmail"]

  puts "limitedCompany upper tier expired registration #{@reg_number} seeded"
end

When("I call NCCC to renew it") do
  # Don't need any code here
end

Then("NCCC are unable to generate a renewal email") do
  sign_in_to_back_office("agency-user")
  visit_registration_details_page(@reg_number)
  expect(@bo.registration_details_page).to have_no_resend_renewal_email_link
end

But("there is an option to renew the registration") do
  expect(@bo.registration_details_page).to have_renew_link
end

Then("I cannot renew again with the same link") do
  visit(@renew_from_email_link)
  expect(@journey.renewal_start_page.heading).to have_text("That registration has already been renewed")
  expect(@journey.renewal_start_page.content).to have_text("Our records show that registration #{@reg_number} has already been renewed.")
end

Then("I am told the renewal cannot be found") do
  expect(@journey.renewal_start_page.heading).to have_text("We cannot find that renewal")
end

Given("I am told that my registration does not expire") do
  expect(page).to have_text("This is a lower tier registration so never expires. Call our helpline on 03708 506506 if you think this is incorrect.")
end

When(/^I change my carrier broker dealer type to "([^"]*)"$/) do |registration_type|
  agree_to_renew_in_england
  @journey.confirm_business_type_page.submit
  @journey.carrier_type_page.submit(choice: registration_type.to_sym)
end

Given(/^I have signed in to renew my registration as "([^"]*)"$/) do |username|
  @journey = JourneyApp.new
  @email_address = username
  sign_in_to_front_office(@email_address)
end

Given("I choose to renew my last registration from the dashboard") do
  @fo.front_office_dashboard.find_registration(@reg_number)
  @fo.front_office_dashboard.renew(@reg_number)
  @reg_type = :renewal
end

Given(/^I change the business type to "([^"]*)"$/) do |org_type|
  agree_to_renew_in_england
  @journey.confirm_business_type_page.submit(org_type: org_type)
end

Given(/^I change my place of business location to "([^"]*)"$/) do |location|
  @journey.renewal_start_page.submit
  @journey.location_page.submit(choice: location.to_sym)
end

Then("I will be able to continue my renewal") do
  @journey.carrier_type_page.wait_until_carrier_dealer_visible
  expect(@journey.tier_check_page.current_url).to include "/cbd-type"
  Capybara.reset_session!
end

When("I complete my {string} renewal steps") do |business_type|
  # business_type must match the options in page_objects/front_office/registrations/business_type_page.rb
  @business_name ||= "#{business_type} renewal" if @business_name.nil?
  @journey.standard_page.accept_cookies

  @journey.renewal_start_page.submit
  @journey.location_page.submit(choice: "england")
  @journey.confirm_business_type_page.submit
  @journey.carrier_type_page.submit
  @journey.renewal_information_page.submit
  # submits company number, name and address
  if @journey.check_registered_company_name_page.heading.has_text? "Is this your registered name and address?"
    # then it's a limited company or LLP:
    expect(@journey.check_registered_company_name_page.companies_house_number).to have_text(/\d{6}/)
    @journey.check_registered_company_name_page.submit(choice: :confirm)
  end
  if business_type == "partnership"
    test_partnership_people
  else
    submit_company_people
  end
  submit_organisation_details(@business_name)

  submit_convictions("no convictions")
  submit_contact_details_for_renewal
  check_your_answers
  order_cards_during_journey(0)
  @journey.payment_summary_page.submit(choice: :card_payment)
  submit_card_payment
end

When(/^I complete my limited liability partnership renewal steps choosing to pay by bank transfer$/) do
  @business_name = "LLP renewal via bank transfer"
  @organisation_type = :limitedLiabilityPartnership
  @tier = :upper
  agree_to_renew_in_england
  @journey.confirm_business_type_page.submit
  @journey.carrier_type_page.submit
  @journey.renewal_information_page.submit
  expect(@journey.check_registered_company_name_page.companies_house_number).to have_text(/\d{6}/)
  @journey.check_registered_company_name_page.submit(choice: :confirm)
  submit_company_people
  @journey.trading_name_question_page.submit(option: :no)
  complete_address_with_random_method
  submit_convictions("no convictions")
  submit_contact_details_for_renewal
  check_your_answers
  order_cards_during_journey(0)
  step("I pay by bank transfer")
end

When("I complete my overseas company renewal steps") do
  @journey.renewal_start_page.submit
  @journey.location_page.submit(choice: :overseas)
  @journey.carrier_type_page.submit
  @journey.renewal_information_page.submit
  people = @journey.company_people_page.main_people
  @journey.company_people_page.submit_main_person(person: people[0])
  @journey.company_name_page.submit
  @journey.address_manual_page.submit(
    house_number: "1",
    address_line_one: "Starý Most",
    address_line_two: "River Danube",
    postcode: "811 02", # required, as tests currently fail without a postcode
    city: "Bratislava",
    country: "Slovakia"
  )
  submit_convictions("no convictions")
  @journey.contact_name_page.submit(
    first_name: "Peter",
    last_name: "O'Hanrahahanrahan"
  )
  @journey.contact_phone_page.submit(phone_number: "0117 4960000")
  @journey.contact_email_page.submit(
    email: "overseas-renewal@example.com",
    confirm_email: "overseas-renewal@example.com"
  )
  @journey.address_manual_page.submit(
    house_number: "1",
    address_line_one: "Via poerio",
    address_line_two: "Via Poerio",
    city: "Rome",
    postcode: "00152", # required, as tests currently fail without a postcode
    country: "Italy"
  )
  check_your_answers
  order_cards_during_journey(0)
  @journey.payment_summary_page.submit(choice: :card_payment)
  submit_card_payment
end

Then(/^I will be notified "([^"]*)"$/) do |message|
  expect(page).to have_text(message)
end

And("I have the option to start a new registration") do
  @journey.standard_page.button.click
  expect(on_fo_start_page?)
end

Then(/^I will be notified my renewal is complete$/) do
  @journey.confirmation_page.wait_until_registration_number_visible
  expect(@journey.confirmation_page.heading.text).to eq("Renewal complete")
  expect(@journey.confirmation_page).to have_text(@reg_number)

  Capybara.reset_session!
end

Then(/^(?:I will receive a registration renewal confirmation email|a registraton renewal confirmation email will be sent)$/) do
  expected_text = ["Your waste carriers registration #{@reg_number} has been renewed", "https://documents.service.gov.uk"]

  expect(message_exists?(expected_text)).to be true
end

Then("I am notified that my renewal payment is being processed") do
  expect(page).to have_content("Application received")
  expect(page).to have_content("We are currently processing your payment")

  @reg_number = @journey.confirmation_page.registration_number.text
  expected_text = [@reg_number]

  expected_text << ("Your application to renew waste carriers registration #{@reg_number} has been received")
  expected_text << "We are currently processing your payment"

  expect(message_exists?(expected_text)).to be true

  puts "Renewal #{@reg_number} submitted and pending WorldPay"
end

Given("I do not confirm my company details are correct") do
  agree_to_renew_in_england
  @journey.confirm_business_type_page.submit
  @journey.carrier_type_page.submit # submit existing carrier type
  @journey.renewal_information_page.submit
  @journey.check_registered_company_name_page.submit(choice: :reject)
end

Then("I will be notified my renewal is pending checks") do
  @journey.confirmation_page.wait_until_registration_number_visible
  expect(@journey.confirmation_page.heading.text).to eq("Application received")
  expect(@journey.confirmation_page).to have_text(@reg_number)
  Capybara.reset_session!
end

Then("I will be notified my renewal is pending payment") do
  @journey.confirmation_page.wait_until_registration_number_visible
  expect(@journey.confirmation_page.heading.text).to eq("Application received")
  expect(@journey.confirmation_page).to have_text("pay the renewal charge")
  expect(@journey.confirmation_page).to have_text(@reg_number)
  Capybara.reset_session!
end

Then(/^(?:I will receive a registration renewal pending payment email|a registraton renewal pending payment email will be sent)$/) do
  expected_text = ["Payment needed for waste carrier registration #{@reg_number}"]

  expect(message_exists?(expected_text)).to be true
end

Then(/^(?:I will receive a registration renewal pending checks email|a registraton renewal pending checks email will be sent)$/) do
  expected_text = ["Your application to renew waste carriers registration #{@reg_number} has been received"]

  expect(message_exists?(expected_text)).to be true
end

Then(/^(?:I will receive a registration renewal processing payment email|a registraton renewal processing payment email will be sent)$/) do
  expected_text = ["We are currently processing your payment", @reg_number]

  expect(message_exists?(expected_text)).to be true
end

When("I start renewing my last registration from the email") do
  @journey = JourneyApp.new
  @reg_type = :renewal
  visit(@renew_from_email_link)
  expect(page).to have_text("You are about to renew registration #{@reg_number}")
end

When("I start the renew from the email") do
  visit(@renew_from_email_link)
  expect(@journey.renewal_start_page.heading).to have_text("You are about to renew registration #{@reg_number}")
  @journey.renewal_start_page.accept_cookies
  @journey.renewal_start_page.submit
  @journey.location_page.submit(choice: "england")
  @journey.confirm_business_type_page.submit
  @journey.carrier_type_page.submit
  @journey.renewal_information_page.submit
end

Then("I will be informed my companies house number could not be validated") do
  expect(@journey.invalid_company_status_page.heading).to have_text("We could not validate your Companies House number")
end
