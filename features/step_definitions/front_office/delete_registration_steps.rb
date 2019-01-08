Given(/I choose to delete my registration "([^"]*)"$/) do |reg_no|
  Capybara.reset_session!
  @front_app = FrontOfficeApp.new
  @front_app.waste_carrier_sign_in_page.load
  @front_app.waste_carrier_sign_in_page.submit(
    email: Quke::Quke.config.custom["accounts"]["waste_carrier"]["username"],
    password: ENV["WCRS_DEFAULT_PASSWORD"]
  )
  @registration_number = reg_no
# Looks for registration on each page of the registrations dashboard
  @front_app.waste_carrier_registrations_page.find_registration(@registration_number)
  @front_app.waste_carrier_registrations_page.delete(@registration_number)

end

When(/^I delete my registration$/) do
  @front_app.confirm_delete_page.delete.click
end

Then(/^I will not see registration "([^"]*)" in my registrations list$/) do |reg_no|
  expect(@front_app.waste_carrier_registrations_page).not_to have_text(reg_no)
end
