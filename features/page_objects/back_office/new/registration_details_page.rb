class RegistrationDetailsPage < SitePrism::Page

  section(:govuk_banner, GovukBanner, GovukBanner::SELECTOR)

  element(:back_link, ".link-back")
  element(:heading, ".heading-large")
  element(:content, ".column-full")

  element(:info_panel, ".wcr-panel-border-all")
  element(:business_name, ".wcr-panel-border-all .heading-medium")

  element(:actions_box, ".wcr-actions--push-down")
  element(:renew_link, "a[href*='/renew/CBD']")
  element(:transfer_link, "a[href*='/transfer-registration']")

end
