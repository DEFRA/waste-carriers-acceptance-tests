Given(/^an Environment Agency user has signed in$/) do
  @app = BackOfficeApp.new
  @app.login_page.load
  @app.login_page.submit(
    email: Quke::Quke.config.custom["accounts"]["AgencyUser"]["username"],
    password: Quke::Quke.config.custom["accounts"]["AgencyUser"]["password"]
  )
end

Given(/^I am signed in as a finance admin$/) do
  @app = BackOfficeApp.new
  @app.login_page.load
  @app.login_page.submit(
    email: Quke::Quke.config.custom["accounts"]["FinanceAdmin"]["username"],
    password: Quke::Quke.config.custom["accounts"]["FinanceAdmin"]["password"]
  )
end

Given(/^I am signed in as an Environment Agency user with refunds$/) do
  @app = BackOfficeApp.new
  @app.login_page.load
  @app.login_page.submit(
    email: Quke::Quke.config.custom["accounts"]["AgencyUserWithPaymentRefund"]["username"],
    password: Quke::Quke.config.custom["accounts"]["AgencyUserWithPaymentRefund"]["password"]
  )
end

Given(/^I request assistance with a new registration$/) do
  @app.registrations_page.new_registration.click
  @app.start_page.submit
end

Then(/^I will have an upper tier registration$/) do
  expect(@app.finish_assisted_page.registration_number).to have_text("CBDU")
  expect(@app.finish_assisted_page).to have_access_code
  expect(@app.finish_assisted_page).to have_view_certificate

  # Stores registration number and access code for later use
  @uppertier_ad_ltd_registration_number = @app.finish_assisted_page.registration_number.text
  @uppertier_ad_ltd_access_code = @app.finish_assisted_page.access_code.text
end

When(/^I pay for my appliction over the phone by maestro ordering (\d+) copy (?:card|cards)$/) do |copy_card_number|
  @app.order_page.submit(
    copy_card_number: copy_card_number,
    choice: :card_payment
  )
  @app.worldpay_card_choice_page.maestro.click

  # finds today's date and adds another year to expiry date
  time = Time.new

  @year = time.year + 1

  @app.worldpay_card_details_page.submit(
    card_number: "6759649826438453",
    security_code: "555",
    cardholder_name: "3d.authorised",
    expiry_month: "12",
    expiry_year: @year
  )
end

Then(/^I will have a lower tier registration$/) do
  expect(@app.finish_assisted_page.registration_number).to have_text("CBDL")
  expect(@app.finish_assisted_page).to have_access_code
  expect(@app.finish_assisted_page).to have_view_certificate

  # Stores registration number and access code for later use
  @lowertier_ad_ltd_registration_number = @app.finish_assisted_page.registration_number.text
  @lowertier_ad_ltd_access_code = @app.finish_assisted_page.access_code.text
end

Then(/^I will be informed by the person taking the call that registration is pending payment$/) do
  expect(@app.finish_assisted_page).to have_text("Registration pending")
  expect(@app.finish_assisted_page.registration_number).to have_text("CBDU")
  expect(@app.finish_assisted_page).to have_access_code

  @uppertier_ad_ltd_registration_number = @app.finish_assisted_page.registration_number.text
  @uppertier_ad_ltd_access_code = @app.finish_assisted_page.access_code.text
end
