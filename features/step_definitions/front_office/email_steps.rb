require "gmail"
# rubocop:disable Metrics/LineLength
Then(/^I have received a "([^"]*)" email/) do |email_text|
  if (Quke::Quke.config.custom["urls"]["front_office"]).include? "local"
    # Opens the second email as the confirmation email will always be first
    @front_app.mailcatcher_main_page.open_email(2)
    expect(@front_app.mailcatcher_main_page).to have_text(email_text)
  else
    # Waits for email to be sent otherwise it could find the email confirmation email for some scenarios
    sleep(5)
    gmail = Gmail.new(ENV["EMAIL_USERNAME"], ENV["EMAIL_PASSWORD"])
    try(20) { @email = gmail.inbox.emails(:unread, from: "registrations@wastecarriersregistration.service.gov.uk").last }
    message_body = @email.message.body
    expect(message_body).to have_text(email_text)
    # Cleans up email for later tests
    @email.read!
  end
end

Then(/^I have received an email "([^"]*)"/) do |email_subject|
  if (Quke::Quke.config.custom["urls"]["front_office"]).include? "local"
    @front_app.mailcatcher_main_page.load
    expect(@front_app.mailcatcher_main_page).to have_text(email_subject)
  else
    # Waits for email to be sent otherwise it could find the email confirmation email for some scenarios
    sleep(5)
    gmail = Gmail.new(ENV["EMAIL_USERNAME"], ENV["EMAIL_PASSWORD"])
    try(20) { @email = gmail.inbox.emails(:unread, from: "registrations@wastecarriersregistration.service.gov.uk").last }
    subject = @email.message.subject
    expect(subject).to have_text(email_subject)
    # Cleans up email for later tests
    @email.read!
  end
end

When(/^I confirm (?:my|the) email address$/) do
  if (Quke::Quke.config.custom["urls"]["front_office"]).include? "local"
    @front_app.mailcatcher_main_page.open_email(1)
    @front_app.mailcatcher_messages_page.confirmation_link.click
  else
    gmail = Gmail.new(ENV["EMAIL_USERNAME"], ENV["EMAIL_PASSWORD"])
    try(20) { @email = gmail.inbox.emails(:unread, from: "registrations@wastecarriersregistration.service.gov.uk").last }
    message_body = @email.message.body.raw_source
    # Uses nokogiri gem to parse html for link to confirm email
    doc = Nokogiri::HTML(message_body)
    url = doc.at_css("a[id='confirmation_link']").text
    # Cleans up email for later tests
    @email.read!
    @front_app = FrontOfficeApp.new
    visit(url)
  end
end
# rubocop:enable Metrics/LineLength
Given(/^I do not confirm my email address$/) do
  # Nothing to do to replicate step
end
