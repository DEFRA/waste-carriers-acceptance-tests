class GovukBanner < SitePrism::Section

  # GOV.UK black banner and menu items

  SELECTOR ||= "#global-header".freeze

  element(:home_page, "#proposition-name")
  element(:manage_users, "a[href='/bo/users']")
  element(:conviction_checks, "a[href='/bo/convictions']")

end
