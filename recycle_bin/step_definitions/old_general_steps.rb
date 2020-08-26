# Delete these steps when finance admin is removed from old app:

Given(/^I am signed in as a finance admin$/) do
  @old = OldApp.new
  @bo = BackOfficeApp.new
  @old.agency_sign_in_page.load
  @old.agency_sign_in_page.submit(
    email: Quke::Quke.config.custom["accounts"]["finance-admin-user"]["username"],
    password: ENV["WCRS_DEFAULT_PASSWORD"]
  )
end

Given(/^I am signed in as a finance user$/) do
  @old = OldApp.new
  @bo = BackOfficeApp.new
  @old.agency_sign_in_page.load
  @old.agency_sign_in_page.submit(
    email: Quke::Quke.config.custom["accounts"]["finance-user"]["username"],
    password: ENV["WCRS_DEFAULT_PASSWORD"]
  )
end

Given(/^I am signed in as an Environment Agency user with refunds$/) do
  Capybara.reset_session!
  @old = OldApp.new
  @bo = BackOfficeApp.new
  @old.agency_sign_in_page.load
  @old.agency_sign_in_page.submit(
    email: Quke::Quke.config.custom["accounts"]["agency-refund-payment-user"]["username"],
    password: ENV["WCRS_DEFAULT_PASSWORD"]
  )
end

Then(/^I will have a lower tier registration$/) do
  expect(@old.finish_assisted_page.registration_number).to have_text("CBDL")
  expect(@old.finish_assisted_page).to have_view_certificate

  # Stores registration number and access code for later use
  @reg_number = @old.finish_assisted_page.registration_number.text
end

Then(/^my registration status for "([^"]*)" will be "([^"]*)"$/) do |search_item, status|
  @old = OldApp.new
  @bo = BackOfficeApp.new
  @old.agency_sign_in_page.load
  @old.agency_sign_in_page.submit(
    email: Quke::Quke.config.custom["accounts"]["agency-user"]["username"],
    password: ENV["WCRS_DEFAULT_PASSWORD"]
  )
  @old.backend_registrations_page.search(search_input: search_item)
  expect(@old.backend_registrations_page.search_results[0].status.text).to eq(status)
end
