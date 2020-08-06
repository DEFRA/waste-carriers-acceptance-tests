# Delete these steps when finance admin is removed from old app:

Given(/^I am signed in as a finance admin$/) do
  @old = OldApp.new
  @bo = BackOfficeApp.new
  @old.agency_sign_in_page.load
  @old.agency_sign_in_page.submit(
    email: Quke::Quke.config.custom["accounts"]["finance-admin-user"]["username"],
    password: ENV["WCRS_DEFAULT_PASSWORD"]
  )
end

Given(/^I am signed in as a finance user$/) do
  @old = OldApp.new
  @bo = BackOfficeApp.new
  @old.agency_sign_in_page.load
  @old.agency_sign_in_page.submit(
    email: Quke::Quke.config.custom["accounts"]["finance-user"]["username"],
    password: ENV["WCRS_DEFAULT_PASSWORD"]
  )
end
