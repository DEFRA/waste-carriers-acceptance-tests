Given(/^an Environment Agency user has signed in to the backend$/) do
  Capybara.reset_session!
  load_all_apps
  @back_app.agency_sign_in_page.load
  @back_app.agency_sign_in_page.submit(
    email: Quke::Quke.config.custom["accounts"]["agency_user"]["username"],
    password: ENV["WCRS_DEFAULT_PASSWORD"]
  )
end

Given(/^I sign into the back office as "([^"]*)"$/) do |user|
  # Use this step to sign in to the back office as any of the following users:
  # agency_user
  # agency_user_with_payment_refund
  # finance_admin
  # finance_basic
  # waste_carrier
  # waste_carrier2
  # agency_super
  load_all_apps
  sign_in_to_back_office(user)
end

Given(/^I am signed in as an Environment Agency user with refunds$/) do
  Capybara.reset_session!
  @back_app = BackEndApp.new
  @bo = BackOfficeApp.new
  @back_app.agency_sign_in_page.load
  @back_app.agency_sign_in_page.submit(
    email: Quke::Quke.config.custom["accounts"]["agency_user_with_payment_refund"]["username"],
    password: ENV["WCRS_DEFAULT_PASSWORD"]
  )
end

Given(/^I have a registration "([^"]*)"$/) do |reg|
  # stores registration number for later use
  @reg_number = reg
end

Given(/^I request assistance with a new registration$/) do
  @back_app.registrations_page.new_registration.click
  @back_app.start_page.submit
  expect(@back_app.location_page.heading).to have_text("Where is your principal place of business?")
  @back_app.location_page.submit(choice: :england)
end

Then(/^I will have an upper tier registration$/) do
  expect(@back_app.finish_assisted_page.registration_number).to have_text("CBDU")

  expect(@back_app.finish_assisted_page).to have_view_certificate

  # Stores registration number and access code for later use
  @reg_number = @back_app.finish_assisted_page.registration_number.text

end

Then(/^I will have a lower tier registration$/) do
  expect(@back_app.finish_assisted_page.registration_number).to have_text("CBDL")
  expect(@back_app.finish_assisted_page).to have_view_certificate

  # Stores registration number and access code for later use
  @reg_number = @back_app.finish_assisted_page.registration_number.text

end

Then(/^the registration has a status of "([^"]*)"$/) do |status|
  sign_in_to_back_office("agency_user")
  @bo.dashboard_page.govuk_banner.home_page.click
  @bo.dashboard_page.submit(search_term: @reg_number)
  expect(@bo.dashboard_page.results_table).to have_text(status)
end

Then(/^the registration does not have a status of "([^"]*)"$/) do |status|
  sign_in_to_back_office("agency_user")
  @bo.dashboard_page.govuk_banner.home_page.click
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
    email: Quke::Quke.config.custom["accounts"]["agency_user"]["username"],
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
    email: Quke::Quke.config.custom["accounts"]["agency_user"]["username"],
    password: ENV["WCRS_DEFAULT_PASSWORD"]
  )
  @back_app.registrations_page.search(search_input: @reg_number)
  @back_app.registrations_page.wait_for_status(status)
  expect(@back_app.registrations_page.search_results[0].status.text).to eq(status)
end
