Given(/^an Environment Agency user has signed in to the backend$/) do
  Capybara.reset_session!
  @back_app = BackEndApp.new
  @bo = BackOfficeApp.new
  @journey = JourneyApp.new
  @renewals_app = RenewalsApp.new
  @back_app.agency_sign_in_page.load
  @back_app.agency_sign_in_page.submit(
    email: Quke::Quke.config.custom["accounts"]["agency_user"]["username"],
    password: ENV["WCRS_DEFAULT_PASSWORD"]
  )
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

Given(/^I am signed in as a finance admin$/) do
  @back_app = BackEndApp.new
  @bo = BackOfficeApp.new
  @back_app.agency_sign_in_page.load
  @back_app.agency_sign_in_page.submit(
    email: Quke::Quke.config.custom["accounts"]["finance_admin"]["username"],
    password: ENV["WCRS_DEFAULT_PASSWORD"]
  )
end

Given(/^I am signed in as a finance user$/) do
  @back_app = BackEndApp.new
  @bo = BackOfficeApp.new
  @back_app.agency_sign_in_page.load
  @back_app.agency_sign_in_page.submit(
    email: Quke::Quke.config.custom["accounts"]["finance_basic"]["username"],
    password: ENV["WCRS_DEFAULT_PASSWORD"]
  )
end

Given(/^I have a registration "([^"]*)"$/) do |reg|
  # stores registration number for later use
  @registration_number = reg
end

Given(/^the registration details are found in the backoffice$/) do
  step "an Environment Agency user has signed in to the backend"
  @back_app.registrations_page.search(search_input: @registration_number)
end

When(/^I ask to pay for my application by bank transfer ordering (\d+) copy (?:card|cards)$/) do |copy_card_number|
  @back_app.order_page.submit(
    copy_card_number: copy_card_number,
    choice: :bank_transfer_payment
  )
  @back_app.offline_payment_page.submit
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
  @registration_number = @back_app.finish_assisted_page.registration_number.text

end

When(/^I pay for my application over the phone by maestro ordering (\d+) copy (?:card|cards)$/) do |copy_card_number|
  @back_app.order_page.submit(
    copy_card_number: copy_card_number,
    choice: :card_payment
  )
  submit_valid_card_payment
end

Then(/^I will have a lower tier registration$/) do
  expect(@back_app.finish_assisted_page.registration_number).to have_text("CBDL")

  expect(@back_app.finish_assisted_page).to have_view_certificate

  # Stores registration number and access code for later use
  @registration_number = @back_app.finish_assisted_page.registration_number.text

end

Then(/^I will be informed by the person taking the call that registration is pending payment$/) do
  expect(@back_app.finish_assisted_page).to have_text("Registration pending")
  expect(@back_app.finish_assisted_page.registration_number).to have_text("CBDU")

  @registration_number = @back_app.finish_assisted_page.registration_number.text

end

Then(/^the registration has a status of "([^"]*)"$/) do |status|
  sign_in_to_back_office
  @bo.dashboard_page.govuk_banner.home_page.click
  @bo.dashboard_page.submit(search_term: @registration_number)
  expect(@bo.dashboard_page.results_table).to have_text(status)
end

Then(/^the registration does not have a status of "([^"]*)"$/) do |status|
  sign_in_to_back_office
  @bo.dashboard_page.govuk_banner.home_page.click
  @bo.dashboard_page.submit(search_term: @registration_number)
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

  result = @back_app.registration_search_results_page.registration(@registration_number)
  expect(result.status.text).to eq(status)
  @back_app.registration_search_results_page.back_link.click
  @back_app.registration_export_page.back_link.click
end

When(/^the registration is revoked$/) do
  @back_app.registrations_page.search(search_input: @registration_number)
  @back_app.registrations_page.wait_for_status("Registered")
  @back_app.registrations_page.search_results[0].revoke.click
  @back_app.revoke_page.submit(revoked_reason: "Did a bad thing")
end

When(/^the registration is deregistered$/) do
  @back_app.registrations_page.search(search_input: @registration_number)
  @back_app.registrations_page.search_results[0].de_register.click
  @back_app.confirm_delete_page.submit
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
  @back_app.registrations_page.search(search_input: @registration_number)
  @back_app.registrations_page.wait_for_status(status)
  expect(@back_app.registrations_page.search_results[0].status.text).to eq(status)
end

And(/^the applicant pays by bank card$/) do
  # On the new app, the payment choice is on a different screen from order copy cards
  if @app == "old"
    old_order_copy_cards(3)
  else
    order_copy_cards(1)
    @bo.payment_summary_page.submit(choice: :card_payment)
  end
  submit_valid_card_payment
end
