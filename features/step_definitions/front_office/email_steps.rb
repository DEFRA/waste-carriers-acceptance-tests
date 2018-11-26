Then(/^I have received an registration complete email/) do
  if (Quke::Quke.config.custom["urls"]["front_office"]).include? "local"
    # Opens the second email as the confirmation email will always be first
    @front_app.mailcatcher_main_page.open_email(2)
    expect(@front_app.mailcatcher_main_page).to have_text "Registration complete"
  else
    # Waits for email to be sent otherwise it could find the email confirmation email for some scenarios
    @front_app.mailinator_page.load
    @front_app.mailinator_page.submit(inbox: @email_address)
    @front_app.mailinator_inbox_page.registration_complete_email.click
    @front_app.mailinator_inbox_page.email_details do |_frame|
      expect(@front_app.registration_confirmed_page).to have_text "Registration complete"
    end
  end
end

Then(/^I have received an application received email/) do
  if (Quke::Quke.config.custom["urls"]["front_office"]).include? "local"
    @front_app.mailcatcher_main_page.load
  else
    # Waits for email to be sent otherwise it could find the email confirmation email for some scenarios
    @front_app.mailinator_page.load
    @front_app.mailinator_page.submit(inbox: @email_address)
  end
    expect(@front_app.mailcatcher_main_page).to have_text "has been received"
end

When(/^I confirm (?:my|the) email address$/) do
  if (Quke::Quke.config.custom["urls"]["front_office"]).include? "local"
    @front_app.mailcatcher_main_page.open_email(1)
    @front_app.mailcatcher_messages_page.confirmation_link.click
  else
    @front_app.mailinator_page.load
    puts @email_address
    @front_app.mailinator_page.submit(inbox: @email_address)
    @front_app.mailinator_inbox_page.wait_for_email
    @front_app.mailinator_inbox_page.confirmation_email.click
    @front_app.mailinator_inbox_page.email_details do |frame|
      @new_window = window_opened_by { frame.confirm_email.click }
    end
  end

end

Given(/^I do not confirm my email address$/) do
  # Nothing to do to replicate step
end
