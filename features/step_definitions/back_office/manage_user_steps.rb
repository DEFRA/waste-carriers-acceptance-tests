require "pry"

When(/^I invite a new "([^"]*)" user$/) do |user_type|
  @bo.dashboard_page.govuk_banner.manage_users_link.click
  expect(@bo.users_page).to be_displayed

  @bo.users_page.invite_user.click

  user_invite_page = @bo.user_invite_page

  expect(user_invite_page).to be_displayed

  @new_user_email = generate_email
  @new_user_role = user_type
  element = "#{user_type}_user_radio"

  user_invite_page.email_field.set(@new_user_email)
  user_invite_page.public_send(element).click
  user_invite_page.submit_form.click

  expect(@bo.users_page).to be_displayed
end

Then(/^the new user has the correct back office permissions$/) do
  within page.find(:css, 'tr', text: /.*#{Regexp.quote(@new_user_email)}.*/) do
    expect(page).to have_text(@new_user_role)
  end
end

Then("the new user receives an email with a link") do
  last_email_page = LastEmailPage.new
  last_email_page.load

  expect(last_email_page.check_email_for_text(["Confirm a waste carriers back office account"])).to be(true)
  @confirm_waste_carriers_email_link = last_email_page.text.match(/.*href\=\\\"(.*)\\\".*/)[1]
end

Then("the new user is able to setup a password following the email's link") do
  Capybara.reset_session!
  visit(@confirm_waste_carriers_email_link)

  user_accept_invite_page = UserAcceptInvitePage.new

  user_accept_invite_page.password_field.set(ENV["WCRS_DEFAULT_PASSWORD"])
  user_accept_invite_page.confirm_password_field.set(ENV["WCRS_DEFAULT_PASSWORD"])
  user_accept_invite_page.submit_field.click
end

Then("the new user is logged in") do
  expect(page).to have_text("Signed in as #{@new_user_email}")
end

When(/^I update the new user role to an "([^"]*)"$/) do |new_role|
  @bo.dashboard_page.govuk_banner.manage_users_link.click
  @new_user_role = new_role

  within page.find(:css, 'tr', text: /.*#{Regexp.quote(@new_user_email)}.*/) do
    click_link("Change role")
  end

  user_amend_page = UserAmendPage.new
  radio_button = "#{new_role.gsub(" ", "_")}_user_radio"
  user_amend_page.public_send(radio_button).click
  user_amend_page.submit_field.click
end

When(/^I remove the new user$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^the new user cannot log in to the back office$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

When(/^I access the user management screen$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^I cannot manage finance users$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^I cannot manage agency users$/) do
  pending # Write code here that turns the phrase above into concrete actions
end
