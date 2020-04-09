# Delete these steps when finance admin is removed from old app:

Given(/^I am signed in as a finance admin$/) do
  @back_app = BackEndApp.new
  @bo = BackOfficeApp.new
  @back_app.agency_sign_in_page.load
  @back_app.agency_sign_in_page.submit(
    email: Quke::Quke.config.custom["accounts"]["finance-admin-user"]["username"],
    password: ENV["WCRS_DEFAULT_PASSWORD"]
  )
end

Given(/^I am signed in as a finance user$/) do
  @back_app = BackEndApp.new
  @bo = BackOfficeApp.new
  @back_app.agency_sign_in_page.load
  @back_app.agency_sign_in_page.submit(
    email: Quke::Quke.config.custom["accounts"]["finance-user"]["username"],
    password: ENV["WCRS_DEFAULT_PASSWORD"]
  )
end
