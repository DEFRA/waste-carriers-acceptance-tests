Given(/^I sign in as an authorised permiting support advisor$/) do
  @app = BackOfficeApp.new
  @app.login_page.load
  visit("/")
  # Back office login page
  @app.login_page.submit(
    email: Quke::Quke.config.custom["accounts"]["PermitingSupportAdvisor"]["username"],
    password: Quke::Quke.config.custom["accounts"]["PermitingSupportAdvisor"]["password"]
  )
end

Given(/^I close the explore dynamics message if present$/) do
  begin
    within_frame "InlineDialog_Iframe" do
      find("#navTourCloseButtonImage").click
    end
  # rubocop:disable Lint/HandleExceptions
  rescue Capybara::ElementNotFound
    # Purposefully do nothing. The dialog only appears to show during the first
    # scenario, so during subsequent ones we'll get an error. So far not found
    # a better way of handling this
  end
  # rubocop:enable Lint/HandleExceptions
end

Given(/^I see the P&SC dashboard$/) do
  # Looks for iframe showing dashboard for Permiting support advisor
  within_frame "contentIFrame0" do
    expect(@app.dashboard_page.dashboard_selector.text).to eq "P&SC Team Lead Dashboard"
  end
end

When(/^I create a new standard rules application$/) do
  within_frame "contentIFrame0" do
    expect(@app.dashboard_page.dashboard_selector.text).to eq("P&SC Team Lead Dashboard")

    within_frame "dashboardFrame" do
      @app.dashboard_page.add_application_btn.click
    end
  end
end

Then(/^I am shown the new application details form$/) do
  within_frame "contentIFrame0" do
    expect(@app.application_details_page.heading.text).to eq("New Application")
  end
end

Given(/^I have an open standard rules application to screen$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

When(/^I mark the appliation screening as successful$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^the application will be ready for its duly made check$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

When(/^I mark the application screening as requiring a consulation$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^the application will be assigned to a permiting advisor$/) do
  pending # Write code here that turns the phrase above into concrete actions
end
