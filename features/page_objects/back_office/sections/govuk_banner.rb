class GovukBanner < SitePrism::Section

  # GOV.UK black banner and menu items

  SELECTOR = ".govuk-service-navigation".freeze

  element(:home_page, ".govuk-service-navigation__service-name .govuk-service-navigation__link")
  element(:conviction_checks_link, "a[href*='/bo/convictions']")
  element(:manage_users_link, "#navigation a[href*='/bo/users']")
  element(:import_convictions_link, "a[href*='/bo/import-convictions']")
  element(:toggle_features_link, "a[href*='/bo/features/feature-toggles']")

end
