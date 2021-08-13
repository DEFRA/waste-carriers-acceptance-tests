class RegistrationDetailsPage < SitePrism::Page

  # View details for registrations or transient renewals

  section(:govuk_banner, GovukBanner, GovukBanner::SELECTOR)

  element(:back_link, ".govuk-back-link")
  element(:flash_message, ".govuk-notification-banner__heading")
  element(:heading, "h1")

  element(:content, ".column-full")
  element(:continue_as_ad_button, ".button", text: "Continue as assisted digital")
  element(:add_missed_worldpay_button, "a[href*='missed']")
  element(:process_payment_button, "a[href*='/payments']")

  element(:info_panel, ".govuk-heading-m+ .govuk-body:nth-child(4)")
  element(:business_name, ".govuk-heading-m:nth-child(3)")

  element(:actions_box, ".wcr-actions--push-down")
  element(:renew_link, "a[href*='/ad-privacy-policy?reg_identifier=CBD']")
  element(:resend_renewal_email_link, "a[href*='/resend-renewal-email']")
  element(:resend_confirmation_email_link, "a[href*='/resend-confirmation-email']")
  element(:transfer_link, "a[href*='/transfer']")
  element(:edit_link, "a[href*='/edit']")
  element(:view_certificate_link, "a[href*='/certificate']")
  element(:order_cards_link, "a[href*='/order-copy-cards']")
  element(:payment_details_link, "a[href*='/finance-details']")
  element(:cease_or_revoke_link, "a[href*='/cease-or-revoke']")
  element(:cancel_link, "a[href*='/cancels']")

  element(:revert_to_payment_summary_link, "a[href$='revert-to-payment-summary']")

  # Sample text on this page:
  #
  # Conviction check required
  # A convictions check is required before this registration can be approved.
  # Convictions
  # This registration has matching or declared convictions.
  # Application rejected
  # This registration was rejected during a convictions check and cannot be completed.
  # Convictions
  # This registration was rejected after a review of the matching or declared convictions.
  # Payment required
  # 164 to pay

end
