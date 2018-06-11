Given(/I choose to delete my registration "([^"]*)"$/) do |reg_no|
  Capybara.reset_session!
  @front_app = FrontOfficeApp.new
  @front_app.waste_carrier_sign_in_page.load
  @front_app.waste_carrier_sign_in_page.submit(
    email: Quke::Quke.config.custom["accounts"]["waste_carrier2"]["username"],
    password: ENV["WASTECARRIERSPASSWORD"]
  )
  @registration_number = reg_no
  @front_app.waste_carrier_registrations_page.registrations[0].delete.click
end

When(/^I delete my registration$/) do
  @front_app.confirm_delete_page.delete.click
end

Then(/^I will not see registration "([^"]*)" in my registrations list$/) do |reg_no|
  expect(@front_app.waste_carrier_registrations_page).not_to have_text(reg_no)
end
