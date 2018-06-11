Given(/^I have registration "([^"]*)"$/) do |arg1|
  # Nothing to do to replicate step
end

When(/^I choose to view my certificate for "([^"]*)"$/) do |reg_no|
  Capybara.reset_session!
  @front_app = FrontOfficeApp.new
  @front_app.waste_carrier_sign_in_page.load
  @front_app.waste_carrier_sign_in_page.submit(
    email: Quke::Quke.config.custom["accounts"]["waste_carrier2"]["username"],
    password: ENV["WASTECARRIERSPASSWORD"]
  )
  @registration_number = reg_no

  registration = @front_app.waste_carrier_registrations_page.registration(@registration_number)
  # puts "Reg no is #{registration[:info].reg_number.text}"
  registration[:controls].view_certificate.click

end

Then(/^I can view my certificate of registration$/) do
  # Using https://stackoverflow.com/a/25438826
  new_window = windows.last
  page.within_window new_window do |_frame|
    expect(@front_app.view_certificate_page).to have_text("Certificate of Registration")
    expect(@front_app.view_certificate_page).to have_text(@registration_number)
  end

end
