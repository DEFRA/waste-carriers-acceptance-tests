class MailinatorInboxPage < SitePrism::Page
  # Mailinator inbox
  # rubocop:disable Metrics/LineLength
  element(:confirmation_email, :xpath, "//*[normalize-space()='Confirm your email address']")
  element(:registration_complete_email, :xpath, "//*[normalize-space()='Waste Carrier Registration Complete']")
  element(:application_received, :xpath, "//*[text()[contains(.,'Your application to renew waste carriers registration')]]")
  # rubocop:enable Metrics/LineLength

  iframe :email_details, MailinatorEmailDetailsPage, "#msg_body"

  def wait_for_email
    refresh_cnt = 0
    loop do
      if has_confirmation_email?
        refresh_cnt = 60
      else
        # reloads the page if service layer hasn't updated in time
        page.evaluate_script("window.location.reload()")
        sleep(5)
        refresh_cnt += 1
      end
      break unless refresh_cnt < 60
    end
  end

end
