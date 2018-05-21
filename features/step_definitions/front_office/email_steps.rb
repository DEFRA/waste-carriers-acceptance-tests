require "gmail"
Then(/^I have received a "([^"]*)" email/) do |email_text|
  # Waits for email to be sent otherwise it'll find the email confirmation email for some scenarios
  sleep(5)
  gmail = Gmail.new(ENV["EMAIL_USERNAME"], ENV["EMAIL_PASSWORD"])
  try(6) { @email = gmail.inbox.emails(:unread, from: "registrations@wastecarriersregistration.service.gov.uk").last }
  message_body = @email.message.body
  # subject = @email.message.subject
  expect(message_body).to have_text(email_text)
  # Marks email as read so it's not found in future searches of unread emails
  @email.read!
end

Then(/^I have received an email "([^"]*)"/) do |email_subject|
  # Waits for email to be sent otherwise it'll find the email confirmation email for some scenarios
  sleep(5)
  gmail = Gmail.new(ENV["EMAIL_USERNAME"], ENV["EMAIL_PASSWORD"])
  try(6) { @email = gmail.inbox.emails(:unread, from: "registrations@wastecarriersregistration.service.gov.uk").last }
  subject = @email.message.subject
  expect(subject).to have_text(email_subject)
  # Marks email as read so it's not found in future searches of unread emails
  @email.read!
end

When(/^I confirm (?:my|the) email address$/) do
  gmail = Gmail.new(ENV["EMAIL_USERNAME"], ENV["EMAIL_PASSWORD"])
  try(6) { @email = gmail.inbox.emails(:unread, from: "registrations@wastecarriersregistration.service.gov.uk").last }
  message_body = @email.message.body.raw_source
  # Uses nokogiri gem to parse html for link to confirm email
  doc = Nokogiri::HTML(message_body)
  url = doc.at_css("a[id='confirmation_link']").text
  # Marks email as read so it's not found in future searches of unread emails
  @email.read!
  @front_app = FrontOfficeApp.new
  visit(url)

  new_window = windows.last
  page.within_window new_window do
    @registration = @front_app.confirmation_page.registration_number.text
    puts @registration
  end
end

Given(/^I do not confirm my email address$/) do
  # Nothing to do to replicate step
end
