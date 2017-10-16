Given(/^an Environment Agency user has signed in$/) do
  @app = BackOfficeApp.new
  @app.login_page.load
  @app.login_page.submit(
    email: Quke::Quke.config.custom["accounts"]["AgencyUser"]["username"],
    password: Quke::Quke.config.custom["accounts"]["AgencyUser"]["password"]
  )
end

Given(/^I request assistance with a new registration$/) do
  @app.registrations_page.new_registration.click
  @app.start_page.submit
end

Then(/^I will have a upper tier registration$/) do
  expect(@app.finish_assisted_page.registration_number).to have_text("CBDU")
  expect(@app.finish_assisted_page).to have_access_code
  expect(@app.finish_assisted_page).to have_view_certificate

  # Stores registration number and access code for later use
  @uppertier_ad_ltd_registration_number = @app.finish_assisted_page.registration_number.text
  @uppertier_ad_ltd_access_code = @app.finish_assisted_page.access_code.text
end

Then(/^I will have a lower tier registration$/) do
  expect(@app.finish_assisted_page.registration_number).to have_text("CBDL")
  expect(@app.finish_assisted_page).to have_access_code
  expect(@app.finish_assisted_page).to have_view_certificate

  # Stores registration number and access code for later use
  @lowertier_ad_ltd_registration_number = @app.finish_assisted_page.registration_number.text
  @lowertier_ad_ltd_access_code = @app.finish_assisted_page.access_code.text
end
