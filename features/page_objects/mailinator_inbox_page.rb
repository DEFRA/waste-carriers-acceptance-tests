class MailinatorInboxPage < SitePrism::Page

  # Mailinator inbox
  element(:confirmation_email, :xpath, "//*[normalize-space()='Confirm your email address']")
  element(:registration_complete_email, :xpath, "//*[normalize-space()='Waste Carrier Registration Complete']")
  element(:registration_pending_payment_email, :xpath, "//*[text()[contains(.,'we are awaiting your payment')]]")

  iframe :email_details, MailinatorEmailDetailsPage, "#msg_body"

end
