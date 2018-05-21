Given(/^I start a new registration$/) do
  @front_app = FrontOfficeApp.new
  @front_app.start_page.load
  @front_app.start_page.submit
end

When(/^I pay for my application by maestro ordering (\d+) copy (?:card|cards)$/) do |copy_card_number|
  @front_app.order_page.submit(
    copy_card_number: copy_card_number,
    choice: :card_payment
  )
  click(@front_app.worldpay_card_choice_page.maestro)

  # finds today's date and adds another year to expiry date
  time = Time.new

  @year = time.year + 1

  @front_app.worldpay_card_details_page.submit(
    card_number: "6759649826438453",
    security_code: "555",
    cardholder_name: "3d.authorised",
    expiry_month: "12",
    expiry_year: @year
  )
  @front_app.worldpay_card_details_page.submit_button.click
end

Then(/^I will be asked to confirm my email address$/) do
  expect(@front_app.confirm_account_page.has_content?("Confirm your email address")).to be(true)
end

Then(/^I will be registered as an upper tier waste carrier$/) do
  expect(@front_app.confirmation_page.registration_number).to have_text("CBDU")
  expect(@front_app.confirmation_page).to have_text @email
  # Stores registration number for later use
  @registration_number = @front_app.confirmation_page.registration_number.text
end

Then(/^I will be registered as a lower tier waste carrier$/) do
  new_window = windows.last
  page.within_window new_window do
    expect(@front_app.confirmation_page.registration_number).to have_text("CBDL")
    expect(@front_app.confirmation_page).to have_text @email
    # Stores registration number for later use
    @registration_number = @front_app.confirmation_page.registration_number.text
  end
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
  expect(@front_app.confirmation_page).to have_text @email
  # Stores registration number for later use
  @registration_number = @front_app.confirmation_page.registration_number.text
end

When(/^I have signed into my account$/) do
  @front_app.waste_carrier_sign_in_page.load
  @front_app.waste_carrier_sign_in_page.submit(
    email: @email,
    password: ENV["WASTECARRIERSPASSWORD"]
  )
end
