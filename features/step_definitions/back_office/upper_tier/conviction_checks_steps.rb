When(/^the conviction check is immediately approved by an agency user$/) do
  approve_conviction_immediately_for_reg(@registration_number, @company_name)
end

When(/^the conviction check is flagged by an agency user$/) do
  flag_conviction_for_reg(@registration_number, @company_name)
end

When(/^the flagged conviction is approved by an agency user$/) do
  approve_flagged_conviction_for_reg(@registration_number, @company_name)
end

When(/^the flagged conviction is rejected by an agency user$/) do
  reject_flagged_conviction_for_reg(@registration_number, @company_name)
end

# DELETE THIS FUNCTION when deregister has moved to the new app.
# Its nearest equivalent is "the registration has a status of":
# Then(/^the registration has a "([^"]*)" status$/) do |status|
#   Capybara.reset_session!
#   @back_app = BackEndApp.new
#   @bo = BackOfficeApp.new
#   @back_app.agency_sign_in_page.load
#   @back_app.agency_sign_in_page.submit(
#     email: Quke::Quke.config.custom["accounts"]["agency_user"]["username"],
#     password: ENV["WCRS_DEFAULT_PASSWORD"]
#   )
#   @back_app.registrations_page.search(search_input: @registration_number)
#   @back_app.registrations_page.wait_for_status(status)
#   expect(@back_app.registrations_page.search_results[0].status.text).to eq(status)
# end
