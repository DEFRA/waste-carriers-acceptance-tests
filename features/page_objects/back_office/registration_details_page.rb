class RegistrationDetailsPage < BasePage

  # View details for registrations or transient renewals

  section(:govuk_banner, GovukBanner, GovukBanner::SELECTOR)

  element(:content, ".column-full")
  element(:continue_as_ad_button, "a[class*='button'][href^='/bo/ad-privacy-policy']")
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
  element(:refresh_company_name, "a[href$='/companies_house_details']")

  element(:revert_to_payment_summary_link, "a[href$='revert-to-payment-summary']")

end
