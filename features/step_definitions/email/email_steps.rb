Then(/^I have received an registration complete email/) do
  if @email_app.local?
    # Opens the second email as the confirmation email will always be first
    @email_app.mailcatcher_main_page.open_email(2)
    expect(@email_app.mailcatcher_main_page).to have_text "You are now registered"
  else
    # Waits for email to be sent otherwise it could find the email confirmation email for some scenarios
    @email_app.mailinator_page.load
    @email_app.mailinator_page.submit(inbox: @email_address)
    @email_app.mailinator_inbox_page.registration_complete_email.click
    @email_app.mailinator_inbox_page.email_details do |_frame|
      expect(@front_app.confirmation_page).to have_text "You are now registered"
    end
  end
end

Then(/^I have received an application received email/) do
  if @email_app.local?
    @email_app.mailcatcher_main_page.load
  else
    # Waits for email to be sent otherwise it could find the email confirmation email for some scenarios
    @email_app.mailinator_page.load
    @email_app.mailinator_page.submit(inbox: @email_address)
  end
  expect(@email_app.mailcatcher_main_page).to have_text "has been received"
end

When(/^I confirm (?:my|the) email address$/) do
  if @email_app.local?
    @email_app.mailcatcher_main_page.open_email(1)
    @email_app.mailcatcher_messages_page.confirmation_link.click
  else
    @email_app.mailinator_page.load
    @email_app.mailinator_page.submit(inbox: @email_address)
    @email_app.mailinator_inbox_page.wait_for_email
    @email_app.mailinator_inbox_page.confirmation_email.click
    @email_app.mailinator_inbox_page.email_details do |frame|
      @new_window = window_opened_by { frame.confirm_email.click }
    end
  end

end

Given(/^I do not confirm my email address$/) do
  # Nothing to do to replicate step
end

Then(/^I will receive an email informing me "([^"]*)"$/) do |text|
  if @email_app.local?
    @email_app.mailcatcher_main_page.open_email(1)
    expect(@email_app.mailcatcher_messages_page).to have_text(text)
  else
    @email_app.mailinator_page.load
    @email_app.mailinator_page.submit(inbox: @email_address)
    expect(@email_app.mailinator_inbox_page).to have_text(text)
  end
end

Then(/^I will receive a renewal appliction received email$/) do
  if @email_app.local?
    @email_app.mailcatcher_main_page.open_email(1)
    expect(@email_app.mailcatcher_messages_page).to have_text("Your application to renew")
  else
    @email_app.mailinator_page
    @email_app.mailinator_page.load
    @email_app.mailinator_page.submit(inbox: @email_address)
    expect(@email_app.mailinator_inbox_page).to have_text("Your application to renew")
    @email_app.mailinator_inbox_page.application_received.click
    @email_app.mailcatcher_messages_page.wait_until_trash_visible
    @email_app.mailcatcher_messages_page.trash.click
  end
end
