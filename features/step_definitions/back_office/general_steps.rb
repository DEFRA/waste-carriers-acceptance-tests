Given(/^an Environment Agency user has signed in to the backend$/) do
  Capybara.reset_session!
  load_all_apps
  @back_app.agency_sign_in_page.load
  @back_app.agency_sign_in_page.submit(
    email: Quke::Quke.config.custom["accounts"]["agency-user"]["username"],
    password: ENV["WCRS_DEFAULT_PASSWORD"]
  )
end

Given("mocking is disabled") do
  pending "It makes no sense to test this feature when mocking is enabled" if mocking_enabled?
end

Given(/^I sign into the back office as "([^"]*)"$/) do |user|
  # Use this step to sign in to the back office as any of the following users:
  # agency-user
  # agency-refund-payment-user
  # agency-super
  # finance-user
  # finance-admin-user
  # finance-super
  # waste_carrier
  # waste_carrier2
  load_all_apps
  sign_in_to_back_office(user)
end

Given(/^I sign out of back office$/) do
  sign_out_of_back_office
end

Given(/^I am signed in as an Environment Agency user with refunds$/) do
  Capybara.reset_session!
  @back_app = BackEndApp.new
  @bo = BackOfficeApp.new
  @back_app.agency_sign_in_page.load
  @back_app.agency_sign_in_page.submit(
    email: Quke::Quke.config.custom["accounts"]["agency-refund-payment-user"]["username"],
    password: ENV["WCRS_DEFAULT_PASSWORD"]
  )
end

Given(/^I request assistance with a new registration$/) do
  visit(Quke::Quke.config.custom["urls"]["back_end_registrations"])
  @back_app.old_start_page.submit
  expect(@journey.location_page.heading).to have_text("Where is your principal place of business?")
  @journey.location_page.submit(choice: :england)
end

Then(/^I will have an upper tier registration$/) do
  expect(@back_app.finish_assisted_page.registration_number).to have_text("CBDU")
  expect(@back_app.finish_assisted_page).to have_view_certificate

  # Stores registration number and access code for later use
  @reg_number = @back_app.finish_assisted_page.registration_number.text
  puts @reg_number + " upper tier registration completed on old app"

end

Then(/^I will have a lower tier registration$/) do
  expect(@back_app.finish_assisted_page.registration_number).to have_text("CBDL")
  expect(@back_app.finish_assisted_page).to have_view_certificate

  # Stores registration number and access code for later use
  @reg_number = @back_app.finish_assisted_page.registration_number.text

end

Then(/^the registration has a status of "([^"]*)"$/) do |status|
  sign_in_to_back_office("agency-refund-payment-user", false)

  @bo.dashboard_page.load
  @bo.dashboard_page.submit(search_term: @reg_number)

  expect(@bo.dashboard_page.results_table).to have_text(status)
end

Then(/^the registration does not have a status of "([^"]*)"$/) do |status|
  sign_in_to_back_office("agency-refund-payment-user", false)

  @bo.dashboard_page.load
  @bo.dashboard_page.submit(search_term: @reg_number)
  expect(@bo.dashboard_page.results_table).to have_no_text(status)
end

Then(/^the registration status in the registration export is set to "([^"]*)"$/) do |status|
  visit(Quke::Quke.config.custom["urls"]["back_end_dashboard"])

  # finds today's date and saves them for use in export from and to date
  time = Time.new

  @year = time.year
  @month = time.strftime("%m")
  @day = time.strftime("%d")

  @today = @day.to_s + "-" + @month.to_s + "-" + @year.to_s

  @back_app.registrations_page.registration_export.click

  @back_app.registration_export_page.submit(
    report_from_date: "30-05-2018",
    report_to_date: @today
  )

  result = @back_app.registration_search_results_page.registration(@reg_number)
  expect(result.status.text).to eq(status)
  @back_app.registration_search_results_page.back_link.click
  @back_app.registration_export_page.back_link.click
end

When(/^the registration is revoked$/) do
  @bo.dashboard_page.view_reg_details(search_term: @reg_number)
  @bo.registration_details_page.cease_or_revoke_link.click
  @bo.cease_or_revoke_page.submit(
    choice: :revoke,
    reason: "Did a naughty thing"
  )
  expect(@bo.cease_or_revoke_page.heading).to have_text("Confirm revoke for registration " + @reg_number)
  @bo.cease_or_revoke_page.confirm_button.click
  expect(@bo.dashboard_page.flash_message).to have_text(@reg_number + " has been revoked")
end

When(/^the registration is ceased$/) do
  @bo.dashboard_page.view_reg_details(search_term: @reg_number)
  @bo.registration_details_page.cease_or_revoke_link.click
  @bo.cease_or_revoke_page.submit(
    choice: :cease,
    reason: "Carrier has stopped carrying waste"
  )
  expect(@bo.cease_or_revoke_page.heading).to have_text("Confirm cease for registration " + @reg_number)
  @bo.cease_or_revoke_page.confirm_button.click
  expect(@bo.dashboard_page.flash_message).to have_text(@reg_number + " has been ceased")
end

Then(/^my registration status for "([^"]*)" will be "([^"]*)"$/) do |search_item, status|
  @back_app = BackEndApp.new
  @bo = BackOfficeApp.new
  @back_app.agency_sign_in_page.load
  @back_app.agency_sign_in_page.submit(
    email: Quke::Quke.config.custom["accounts"]["agency-user"]["username"],
    password: ENV["WCRS_DEFAULT_PASSWORD"]
  )
  @back_app.registrations_page.search(search_input: search_item)
  expect(@back_app.registrations_page.search_results[0].status.text).to eq(status)
end

Then(/^(?:the|my) registration status will be "([^"]*)"$/) do |status|
  # resets session cookies to fix back office authentication issue
  Capybara.reset_session!
  @back_app = BackEndApp.new
  @bo = BackOfficeApp.new
  @back_app.agency_sign_in_page.load
  @back_app.agency_sign_in_page.submit(
    email: Quke::Quke.config.custom["accounts"]["agency-user"]["username"],
    password: ENV["WCRS_DEFAULT_PASSWORD"]
  )
  @back_app.registrations_page.search(search_input: @reg_number)
  @back_app.registrations_page.wait_for_status(status)
  expect(@back_app.registrations_page.search_results[0].status.text).to eq(status)
end
