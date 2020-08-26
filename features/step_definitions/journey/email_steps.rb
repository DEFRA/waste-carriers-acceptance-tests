Then(/^I receive a frontend email with text "([^"]*)"$/) do |text|
  # Same as 'I will receive an email with text' but on frontend.
  # Delete this step when we get rid of frontend!
  visit(Quke::Quke.config.custom["urls"]["last_email_fe"])
  expect(retrieve_email_containing([text])).to have_text(text)
end

When(/^I confirm (?:my|the) email address$/) do
  visit(Quke::Quke.config.custom["urls"]["last_email_fe"])
  confirmation_email_text = retrieve_email_containing([@email_address]).to_s
  expect(confirmation_email_text).to have_text("The next step is for you to confirm your email address")

  # Get the confirmation email link from the email text:
  # rubocop:disable Style/RedundantRegexpEscape
  confirmation_email_link = confirmation_email_text.match(/.*href\=\\"(.*)\\">http.*/)[1].to_s
  # rubocop:enable Style/RedundantRegexpEscape
  visit(confirmation_email_link)
end

Given(/^I do not confirm my email address$/) do
  # Nothing to do to replicate step
end

Then(/^I will receive an email with text "([^"]*)"$/) do |text|
  visit(Quke::Quke.config.custom["urls"]["last_email_fo"])
  expect(retrieve_email_containing([text])).to have_text(text)
end
