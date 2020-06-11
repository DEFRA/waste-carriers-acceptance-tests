Given(/^I start a new registration$/) do
  # This step coversa registration from the old app.
  @front_app = FrontOfficeApp.new
  @journey = JourneyApp.new
  @front_app.old_start_page.load
  @front_app.old_start_page.submit
  # Redirects to "Where is your principal place of business?"
  expect(@journey.location_page.heading).to have_text("Where is your principal place of business?")
  # Select England as the principal place of business:
  @journey.location_page.submit(choice: :england)
end

When(/^I pay for my application by maestro ordering (\d+) copy (?:card|cards)$/) do |copy_card_number|
  @front_app.order_page.submit(
    copy_card_number: copy_card_number,
    choice: :card_payment
  )

  submit_valid_card_payment

  @reg_number = find("#registrationNumber").text
  puts "Registration " + @reg_number + " completed by card"
end

Then(/^I will be asked to confirm my email address$/) do
  expect(@front_app.confirm_account_page.has_content?("Confirm your email address")).to be(true)
end

Then(/^I will be registered as an upper tier waste carrier$/) do
  expect(@front_app.old_confirmation_page.registration_number).to have_text("CBDU")
  expect(@front_app.old_confirmation_page).to have_text @email_address
  # Stores registration number for later use
  @reg_number = @front_app.old_confirmation_page.registration_number.text
  puts "Upper tier registration " + @reg_number + " completed"
end

Then(/^I will be registered as a lower tier waste carrier$/) do
  if @email_app.local?
    expect(@front_app.old_confirmation_page.registration_number).to have_text("CBDL")
    expect(@front_app.old_confirmation_page).to have_text @email_address
    # Stores registration number for later use
    @reg_number = @front_app.old_confirmation_page.registration_number.text
  else
    within_window @new_window do
      @front_app.old_confirmation_page.wait_until_registration_number_visible
      expect(@front_app.old_confirmation_page.registration_number).to have_text("CBDL")
      expect(@front_app.old_confirmation_page).to have_text @email
      # Stores registration number for later use
      @reg_number = @front_app.old_confirmation_page.registration_number.text
    end
  end
  puts "Lower tier registration " + @reg_number + " completed"
end

When(/^I select that I don't know what business type to enter$/) do
  @front_app.business_type_page.submit(org_type: "other")
end

Then(/^I will be informed to contact the Environment Agency$/) do
  expect(@front_app.no_registration_page).to have_text "Contact the Environment Agency"
end

When(/^I choose to pay for my application by bank transfer ordering (\d+) copy (?:card|cards)$/) do |copy_card_number|
  @front_app.order_page.submit(
    copy_card_number: copy_card_number,
    choice: :bank_transfer_payment
  )
  @front_app.offline_payment_page.submit
end

Then(/^I will be informed my registration is pending payment$/) do
  expect(@front_app.old_confirmation_page).to have_text "Application received"
  expect(@front_app.old_confirmation_page).to have_text @email_address
  # Stores registration number for later use
  @reg_number = @front_app.old_confirmation_page.registration_number.text
end

When(/^I have signed into my account$/) do
  @front_app.waste_carrier_sign_in_page.load
  @front_app.waste_carrier_sign_in_page.submit(
    email: @email_address,
    password: ENV["WCRS_DEFAULT_PASSWORD"]
  )
end

Given(/^I have signed in as "([^"]*)"$/) do |username|
  @front_app = FrontOfficeApp.new
  @journey = JourneyApp.new
  @front_app.waste_carrier_sign_in_page.load
  @front_app.waste_carrier_sign_in_page.submit(
    email: username,
    password: ENV["WCRS_DEFAULT_PASSWORD"]
  )
end

Given(/^I choose to renew my registration using my previous registration number$/) do
  Capybara.reset_session!
  @front_app = FrontOfficeApp.new
  @journey = JourneyApp.new
  @front_app.old_start_page.load
  @front_app.old_start_page.submit(renewal: true)
  @front_app.existing_registration_page.submit(reg_no: @reg_number)
end

Then(/^I will be told "([^"]*)"$/) do |message|
  expect(@front_app.existing_registration_page).to have_text(message)
end

Given("I have reached the GOV.UK start page") do
  @fo = FrontOfficeApp.new
  visit("https://www.gov.uk/waste-carrier-or-broker-registration")
  expect(@fo.govuk_start_page.heading).to have_text("Register or renew as a waste carrier, broker or dealer (England)")
end

When("I access the links on the page") do
  # Select Wales
  find_link("Register or renew as a waste carrier, broker or dealer (Wales)").click
  expect(@fo.govuk_start_page.heading).to have_text("Register or renew as a waste carrier, broker or dealer (Wales)")
  find_link("Register or renew as a waste carrier, broker or dealer (England)").click

  # Select Scotland
  find_link("Register or renew as a waste carrier or broker (Scotland)").click
  expect(@fo.govuk_start_page.heading).to have_text("Register or renew as a waste carrier or broker (Scotland)")
  page.evaluate_script("window.history.back()")

  # Select Northern Ireland
  find_link("Register or renew as a waste carrier or broker (Northern Ireland)").click
  expect(@fo.govuk_start_page.heading).to have_text("Register or renew as a waste carrier or broker (Northern Ireland)")
  find_link("England").click

  # Select public register
  find_link("public register of waste carriers, brokers and dealers").click
  expect(page).to have_text("Choose a register to search")
  page.evaluate_script("window.history.back()")

  # Select "renew your registration"
  find_link("renew your registration").click
  expect(page).to have_text("Is this a new registration?")
  page.evaluate_script("window.history.back()")

  # Select "Start now"
  @fo.govuk_start_page.start_now_button.click
end

Then("I can start my registration") do
  expect(@fo.old_start_page.heading).to have_text("Is this a new registration?")
end
