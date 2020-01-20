class ViewDetailsPage < SitePrism::Page

  # View details for registrations or transient renewals

  section(:govuk_banner, GovukBanner, GovukBanner::SELECTOR)

  element(:back_link, ".link-back")
  element(:heading, ".heading-large")

  element(:content, ".column-full")
  element(:continue_as_ad_button, ".button", text: "Continue as assisted digital")

  element(:actions_box, ".wcr-actions--push-down")
  element(:renew_link, "a[href*='/ad-privacy-policy/CBD']")
  element(:transfer_link, "a[href*='/transfer']")
  element(:order_cards_link, "a[href*='/order-copy-cards']")
  element(:payment_details_link, "a[href*='/finance_details']")
  element(:cease_or_revoke_link, "a[href*='/cease-or-revoke']")

  element(:info_panel, ".wcr-panel-border-all")
  element(:business_name, ".wcr-panel-border-all .heading-medium")

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
