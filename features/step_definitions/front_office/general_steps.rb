Given(/^I start a new registration$/) do
  @app = FrontOfficeApp.new
  @app.start_page.load
  @app.start_page.submit
end

Given(/^I answer questions that indicate I'm a lower tier waste carrier$/) do
  pending
end

Then(/^I will be registered as lower tier waste carrier$/) do
  pending # Write code here that turns the phrase above into concrete actions
end
