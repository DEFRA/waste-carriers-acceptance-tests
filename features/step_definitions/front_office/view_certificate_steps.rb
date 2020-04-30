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
  # Using https://stackoverflow.com/a/25438826
  @front_app.waste_carrier_registrations_page.view_certificate(@reg_number)
  new_window = windows.last
  page.within_window new_window do |_frame|
    expect(@front_app.view_certificate_page).to have_text("Certificate of Registration")
    expect(@front_app.view_certificate_page).to have_text(@reg_number)
  end

end
