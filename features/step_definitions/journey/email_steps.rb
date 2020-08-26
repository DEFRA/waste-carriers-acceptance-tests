Then(/^I receive a frontend email with text "([^"]*)"$/) do |text|
  # Same as 'I will receive an email with text' but on frontend.
  # Delete this step when we get rid of frontend!
  visit(Quke::Quke.config.custom["urls"]["last_email_fe"])
  expect(retrieve_email_containing([text])).to have_text(text)
end

Then(/^I will receive an email with text "([^"]*)"$/) do |text|
  visit(Quke::Quke.config.custom["urls"]["last_email_fo"])
  expect(retrieve_email_containing([text])).to have_text(text)
end
