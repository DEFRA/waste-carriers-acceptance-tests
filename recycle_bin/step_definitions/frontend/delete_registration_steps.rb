Given(/I choose to delete my registration "([^"]*)"$/) do |reg_no|
  Capybara.reset_session!
  @old = OldApp.new
  @journey = JourneyApp.new
  @old.frontend_sign_in_page.load
  @old.frontend_sign_in_page.submit(
    email: Quke::Quke.config.custom["accounts"]["waste_carrier2"]["username"],
    password: ENV["WCRS_DEFAULT_PASSWORD"]
  )
  @reg_number = reg_no
  # Looks for registration on each page of the registrations dashboard
  @fo.front_office_dashboard.find_registration(@reg_number)
  @fo.front_office_dashboard.delete(@reg_number)

end

When(/^I delete my registration$/) do
  @old.confirm_delete_page.delete.click
end

Then(/^I will not see registration "([^"]*)" in my registrations list$/) do |reg_no|
  expect(@fo.front_office_dashboard).not_to have_text(reg_no)
end
