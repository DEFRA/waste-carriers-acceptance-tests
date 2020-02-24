Given(/^I choose to transfer ownership of "([^"]*)" to another user$/) do |reg|
  @registration_number = reg
  @bo.dashboard_page.view_reg_details(search_term: reg)
  @bo.registration_details_page.transfer_link.click
end

When(/^I change the account email to "([^"]*)"$/) do |email|
  @bo.transfer_registration_page.submit(
    email: email,
    confirm_email: email
  )
  # saves email value for later on
  @email = email
end

Then(/^I see a confirmation the change has been made$/) do
  expect(@bo.transfer_registration_page).to have_text(@email)
end
