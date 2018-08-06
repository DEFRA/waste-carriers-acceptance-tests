Given(/^I have signed into the renewals service$/) do
  @back_renewals_app = BackOfficeRenewalsApp.new
  @back_renewals_app.admin_sign_in_page.load
  # Change user to admin user once that work is done
  @back_renewals_app.admin_sign_in_page.submit(
    email: Quke::Quke.config.custom["accounts"]["waste_carrier"]["username"],
    password: ENV["WCRS_DEFAULT_PASSWORD"]
  )
end

Given(/^I choose to renew "([^"]*)"$/) do |reg|
  renewal_url = Quke::Quke.config.custom["urls"]["back_office_renewals"] + "/bo/renew/#{reg}"

  visit(renewal_url)
  # save registration number for checks later on
  @registration_number = reg
end

When(/^I renew the public body registration$/) do
  pending # Write code here that turns the phrase above into concrete actions
end
