When(/^I choose to view my certificate$/) do
  Capybara.reset_session!
  @front_app = FrontOfficeApp.new
  @journey = JourneyApp.new
  @front_app.waste_carrier_sign_in_page.load
  @front_app.waste_carrier_sign_in_page.submit(
    email: Quke::Quke.config.custom["accounts"]["waste_carrier2"]["username"],
    password: ENV["WCRS_DEFAULT_PASSWORD"]
  )
  @front_app.waste_carrier_registrations_page.find_registration(@reg_number)
end

Then(/^I can view my certificate of registration$/) do
  # We need to bypass the PDF link by going directly to the HTML version of the certificate.
  visit("#{Quke::Quke.config.custom['urls']['front_office']}/registrations/#{@reg_number}/certificate?show_as_html=true")
  expect(page).to have_text("Certificate of Registration")
  expect(page).to have_text(@reg_number)
  page.evaluate_script("window.history.back()")
end
