Given(/^I start a new registration$/) do
  @front_app = FrontOfficeApp.new
  @journey = JourneyApp.new
  @front_app.start_page.load
  @front_app.start_page.submit
  # Redirects to "Where is your principal place of business?"
  expect(@front_app.location_page.heading).to have_text("Where is your principal place of business?")
  # Select England as the principal place of business:
  @front_app.location_page.submit(choice: :england)
end

When(/^I pay for my application by maestro ordering (\d+) copy (?:card|cards)$/) do |copy_card_number|
  @front_app.order_page.submit(
    copy_card_number: copy_card_number,
    choice: :card_payment
  )

  submit_valid_card_payment
end

Then(/^I will be asked to confirm my email address$/) do
  expect(@front_app.confirm_account_page.has_content?("Confirm your email address")).to be(true)
end

Then(/^I will be registered as an upper tier waste carrier$/) do
  expect(@front_app.confirmation_page.registration_number).to have_text("CBDU")
  expect(@front_app.confirmation_page).to have_text @email_address
  # Stores registration number for later use
  @reg_number = @front_app.confirmation_page.registration_number.text
  puts "Upper tier registration " + @reg_number + " completed"
end

Then(/^I will be registered as a lower tier waste carrier$/) do
  if @email_app.local?
    expect(@front_app.confirmation_page.registration_number).to have_text("CBDL")
    expect(@front_app.confirmation_page).to have_text @email_address
    # Stores registration number for later use
    @reg_number = @front_app.confirmation_page.registration_number.text
  else
    within_window @new_window do
      @front_app.confirmation_page.wait_until_registration_number_visible
      expect(@front_app.confirmation_page.registration_number).to have_text("CBDL")
      expect(@front_app.confirmation_page).to have_text @email
      # Stores registration number for later use
      @reg_number = @front_app.confirmation_page.registration_number.text
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
  expect(@front_app.confirmation_page).to have_text "Application received"
  expect(@front_app.confirmation_page).to have_text @email_address
  # Stores registration number for later use
  @reg_number = @front_app.confirmation_page.registration_number.text
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
  @front_app.start_page.load
  @front_app.start_page.submit(renewal: true)
  @front_app.existing_registration_page.submit(reg_no: @reg_number)
end

Then(/^I will be told "([^"]*)"$/) do |message|
  expect(@front_app.existing_registration_page).to have_text(message)
end
