Given(/^an Environment Agency user has signed in$/) do
  @back_app = BackOfficeApp.new
  @back_app.agency_sign_in_page.load
  @back_app.agency_sign_in_page.submit(
    email: Quke::Quke.config.custom["accounts"]["agency_user"]["username"],
    password: Quke::Quke.config.custom["accounts"]["agency_user"]["password"]
  )
end

Given(/^I am signed in as an Environment Agency user with refunds$/) do
  @back_app = BackOfficeApp.new
  @back_app.agency_sign_in_page.load
  @back_app.agency_sign_in_page.submit(
    email: Quke::Quke.config.custom["accounts"]["agency_user_with_payment_refund"]["username"],
    password: Quke::Quke.config.custom["accounts"]["agency_user_with_payment_refund"]["password"]
  )
end

Given(/^I am signed in as a finance admin$/) do
  @back_app = BackOfficeApp.new
  @back_app.agency_sign_in_page.load
  @back_app.agency_sign_in_page.submit(
    email: Quke::Quke.config.custom["accounts"]["finance_admin"]["username"],
    password: Quke::Quke.config.custom["accounts"]["finance_admin"]["password"]
  )
end

Given(/^I am signed in as a finance user$/) do
  @back_app = BackOfficeApp.new
  @back_app.agency_sign_in_page.load
  @back_app.agency_sign_in_page.submit(
    email: Quke::Quke.config.custom["accounts"]["finance_basic"]["username"],
    password: Quke::Quke.config.custom["accounts"]["finance_basic"]["password"]
  )
end

Given(/^the registration details are found in the backoffice$/) do
  step "an Environment Agency user has signed in"
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
end

Then(/^I will have an upper tier registration$/) do
  expect(@back_app.finish_assisted_page.registration_number).to have_text("CBDU")
  expect(@back_app.finish_assisted_page).to have_access_code
  expect(@back_app.finish_assisted_page).to have_view_certificate

  # Stores registration number and access code for later use
  @registration_number = @back_app.finish_assisted_page.registration_number.text
  @access_code = @back_app.finish_assisted_page.access_code.text
end

When(/^I pay for my application over the phone by maestro ordering (\d+) copy (?:card|cards)$/) do |copy_card_number|
  @back_app.order_page.submit(
    copy_card_number: copy_card_number,
    choice: :card_payment
  )
  BackOfficeApp.click(@back_app.worldpay_card_choice_page.maestro)

  # finds today's date and adds another year to expiry date
  time = Time.new

  @year = time.year + 1

  @back_app.worldpay_card_details_page.submit(
    card_number: "6759649826438453",
    security_code: "555",
    cardholder_name: "3d.authorised",
    expiry_month: "12",
    expiry_year: @year
  )
end

Then(/^I will have a lower tier registration$/) do
  expect(@back_app.finish_assisted_page.registration_number).to have_text("CBDL")
  expect(@back_app.finish_assisted_page).to have_access_code
  expect(@back_app.finish_assisted_page).to have_view_certificate

  # Stores registration number and access code for later use
  @registration_number = @back_app.finish_assisted_page.registration_number.text
  @access_code = @back_app.finish_assisted_page.access_code.text
end

Then(/^I will be informed by the person taking the call that registration is pending payment$/) do
  expect(@back_app.finish_assisted_page).to have_text("Registration pending")
  expect(@back_app.finish_assisted_page.registration_number).to have_text("CBDU")
  expect(@back_app.finish_assisted_page).to have_access_code

  @registration_number = @back_app.finish_assisted_page.registration_number.text
  @access_code = @back_app.finish_assisted_page.access_code.text
end

Then(/^the registration status in the registration export is set to "([^"]*)"$/) do |status|
  # finds today's date and saves them for use in export from and to date
  time = Time.new

  @year = time.year
  @month = time.strftime("%m")
  @day = time.strftime("%d")

  @today = @day.to_s + "-" + @month.to_s + "-" + @year.to_s

  @back_app.registrations_page.registration_export.click

  @back_app.registration_export_page.submit(
    report_from_date: @today,
    report_to_date: @today
  )

  result = @back_app.registration_search_results_page.registration(@registration_number)

  expect(result.status.text).to eq(status)
  @back_app.registration_search_results_page.back_link.click
  @back_app.registration_export_page.back_link.click
end

When(/^the registration is revoked$/) do
  @back_app.registrations_page.search(search_input: @registration_number)
  @back_app.registrations_page.search_results[0].revoke.click
  @back_app.revoke_page.submit(revoked_reason: "Did a bad thing")
end

When(/^the registration is deregistered$/) do
  @back_app.registrations_page.search(search_input: @registration_number)
  @back_app.registrations_page.search_results[0].de_register.click
  @back_app.confirm_delete_page.submit
end
