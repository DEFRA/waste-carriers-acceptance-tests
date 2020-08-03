class GovukBanner < SitePrism::Section

  # GOV.UK black banner and menu items

  SELECTOR ||= "#global-header".freeze

  element(:home_page, "#proposition-name")
  element(:conviction_checks_link, "a[href*='/bo/convictions']")
  element(:manage_users_link, "a[href*='/bo/users']")
  element(:letters_link, "a[href*='/bo/letters']")
  element(:import_convictions_link, "a[href*='/bo/import-convictions']")
  element(:toggle_features_link, "a[href*='/bo/features/feature-toggles']")

end
