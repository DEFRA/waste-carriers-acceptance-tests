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
  look_into_paginated_content_for(@new_user_email)

  within page.first(:css, "tr", text: /.*#{Regexp.quote(@new_user_email)}.*/) do
    expect(page).to have_text(@new_user_role)
  end
end

Then("the new user accepts their invitation and sets up a password") do
  visit(Quke::Quke.config.custom["urls"]["last_email_bo"])
  invitation_email_text = retrieve_email_containing(["Confirm a waste carriers back office account", @new_user_email])

  @confirm_waste_carriers_email_link = invitation_email_text.match(/.*href\=\\\"(.*)\\\".*/)[1]

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

  look_into_paginated_content_for(@new_user_email)

  within page.first(:css, "tr", text: /.*#{Regexp.quote(@new_user_email)}.*/) do
    click_link("Change role")
  end

  user_amend_page = UserAmendPage.new
  radio_button = "#{new_role.gsub(' ', '_')}_user_radio"
  user_amend_page.public_send(radio_button).click
  user_amend_page.submit_field.click
end

When(/^I deactivate the new user$/) do
  @bo.dashboard_page.govuk_banner.manage_users_link.click

  look_into_paginated_content_for(@new_user_email)

  within page.first(:css, "tr", text: /.*#{Regexp.quote(@new_user_email)}.*/) do
    click_link("Deactivate")
  end

  user_deactivate_page = UserDeactivatePage.new
  user_deactivate_page.submit_field.click
end

Then(/^the new user cannot log in to the back office$/) do
  Capybara.reset_session!

  @bo.sign_in_page.load

  @bo.sign_in_page.submit(
    email: @new_user_email,
    password: ENV["WCRS_DEFAULT_PASSWORD"]
  )

  expect(page).to have_text("Your account has been deactivated")
end

When(/^I access the user management screen$/) do
  @bo.dashboard_page.govuk_banner.manage_users_link.click
  expect(@bo.users_page).to be_displayed
end

Then(/^I cannot manage finance users$/) do
  ["finance-user@wcr.gov.uk", "finance-super@wcr.gov.uk", "finance-admin-user@wcr.gov.uk"].each do |email|
    look_into_paginated_content_for(email)

    within page.first(:css, "tr", text: /.*#{Regexp.quote(email)}.*/) do
      expect(page).to_not have_link("Deactivate")
      expect(page).to_not have_link("Change role")
    end
  end
end

Then(/^I cannot manage agency users$/) do
  ["agency-refund-payment-user@wcr.gov.uk", "agency-super@wcr.gov.uk", "agency-user@wcr.gov.uk"].each do |email|
    look_into_paginated_content_for(email)

    within page.first(:css, "tr", text: /.*#{Regexp.quote(email)}.*/) do
      expect(page).to_not have_link("Deactivate")
      expect(page).to_not have_link("Change role")
    end
  end
end
