Then(/^I will receive an email with text "([^"]*)"$/) do |text|
  visit(Quke::Quke.config.custom["urls"]["last_email_fo"])
  expect(retrieve_email_containing([text])).to have_text(text)
end
