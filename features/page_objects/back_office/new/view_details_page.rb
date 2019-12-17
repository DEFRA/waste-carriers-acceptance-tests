class ViewDetailsPage < SitePrism::Page

  # View details for registrations or transient renewals

  section(:govuk_banner, GovukBanner, GovukBanner::SELECTOR)

  element(:back_link, ".link-back")
  element(:heading, ".heading-large")

  element(:content, ".column-full")
  element(:continue_as_ad_button, ".button", text: "Continue as assisted digital")

  element(:info_panel, ".wcr-panel-border-all")
  element(:business_name, ".wcr-panel-border-all .heading-medium")

  element(:actions_box, ".wcr-actions--push-down")
  element(:renew_link, "a[href*='/ad-privacy-policy/CBD']")
  element(:transfer_link, "a[href*='/transfer-registration']")

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
