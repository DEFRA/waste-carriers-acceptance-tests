require "faker"

Given(/I have a registration "([^"]*)"$/) do |reg_no|
  # reserves registration number for specific test
  @registration_number = reg_no
end

Given(/^the user has 2 registrations$/) do
  @front_app = FrontOfficeApp.new
  @first_name = Faker::Name.first_name
  @last_name = Faker::Name.last_name
  @email_address = @front_app.generate_email
  @registrations = []

  @front_app.start_page.load
  @front_app.start_page.submit
  @front_app.business_type_page.submit(org_type: "charity")

  @front_app.business_details_page.submit(
    company_name: Faker::Company.name,
    postcode: "BS1 5AH",
    result: "NATURAL ENGLAND, HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH"
  )

  @front_app.contact_details_page.submit(
    first_name: @first_name,
    last_name: @last_name,
    phone_number: "012345678",
    email: @email_address
  )

  @front_app.postal_address_page.submit
  @front_app.check_details_page.submit

  @front_app.sign_up_page.submit(
    registration_password: ENV["WCRS_DEFAULT_PASSWORD"],
    confirm_password: ENV["WCRS_DEFAULT_PASSWORD"],
    confirm_email: @email_address
  )
  @front_app.start_page.load
  @front_app.start_page.submit
  @front_app.business_type_page.submit(org_type: "charity")

  @front_app.business_details_page.submit(
    company_name: Faker::Company.name,
    postcode: "BS1 5AH",
    result: "NATURAL ENGLAND, HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH"
  )

  @front_app.contact_details_page.submit(
    first_name: @first_name,
    last_name: @last_name,
    phone_number: "012345678",
    email: @email_address
  )

  @front_app.postal_address_page.submit
  @front_app.check_details_page.submit

  @front_app.waste_carrier_sign_in_page.submit(
    password: ENV["WCRS_DEFAULT_PASSWORD"]
  )

  @registrations << @front_app.confirmation_page.registration_number.text
end

When(/^I change the account email$/) do
  @back_app.registrations_page.search(search_input: @registration_number)
  @back_app.registrations_page.search_results[0].change_account_email.click

  @new_email = @back_app.generate_email
  @back_app.edit_account_email_page.submit(email: @new_email)
end

When(/^I change the account email for both$/) do
  @registrations.each do |_reg_no|
    @back_app.registrations_page.search(search_input: @registration_number)
    @back_app.registrations_page.search_results[0].change_account_email.click

    @new_email = @front_app.generate_email
    @back_app.edit_account_email_page.submit(email: @new_email)

    expect(@back_app.edit_account_email_page).to have_notice

    @back_app.edit_account_email_page.back_link.click
  end
end

Then(/^I see a confirmation the change has been made$/) do
  expect(@back_app.edit_account_email_page).to have_notice
end

Then(/^I see a confirmation for both$/) do
  # I do nothing. The expect() call actually takes place in
  # `I change the account email for both` because there is no way to see the
  # notice other than at the time of making the change.
  # Having this step just makes the scenario read better :-)
end
