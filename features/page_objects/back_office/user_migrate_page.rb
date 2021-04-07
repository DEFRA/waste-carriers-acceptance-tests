require_relative "sections/govuk_banner"

class UserMigratePage < SitePrism::Page

  section(:govuk_banner, GovukBanner, GovukBanner::SELECTOR)

  element(:migrate_users, "input[value='Migrate users']")

end
