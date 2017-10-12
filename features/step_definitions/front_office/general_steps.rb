Given(/^I start a new registration$/) do
  @app = FrontOfficeApp.new
  @app.start_page.load
  @app.start_page.submit
end

Then(/^I will be registered as an upper tier waste carrier$/) do
  expect(@app.registration_confirmed_page.registration_number).to have_text("CBDU")
  expect(@app.registration_confirmed_page).to have_text @email
  # Stores registration number for later use
  @uppertier_registration_number = @app.registration_confirmed_page.registration_number.text
end
