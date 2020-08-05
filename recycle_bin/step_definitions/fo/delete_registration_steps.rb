Given(/I choose to delete my registration "([^"]*)"$/) do |reg_no|
  Capybara.reset_session!
  @front_app = FrontOfficeApp.new
  @journey = JourneyApp.new
  @fo.waste_carrier_sign_in_page.load
  @fo.waste_carrier_sign_in_page.submit(
    email: Quke::Quke.config.custom["accounts"]["waste_carrier2"]["username"],
    password: ENV["WCRS_DEFAULT_PASSWORD"]
  )
  @reg_number = reg_no
  # Looks for registration on each page of the registrations dashboard
  @fo.waste_carrier_registrations_page.find_registration(@reg_number)
  @fo.waste_carrier_registrations_page.delete(@reg_number)

end

When(/^I delete my registration$/) do
  @front_app.confirm_delete_page.delete.click
end

Then(/^I will not see registration "([^"]*)" in my registrations list$/) do |reg_no|
  expect(@fo.waste_carrier_registrations_page).not_to have_text(reg_no)
end
