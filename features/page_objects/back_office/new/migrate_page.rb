require_relative "sections/govuk_banner.rb"

class MigratePage < SitePrism::Page

  section(:govuk_banner, GovukBanner, GovukBanner::SELECTOR)

  element(:migrate_users, "input[value='Migrate users']")

end
