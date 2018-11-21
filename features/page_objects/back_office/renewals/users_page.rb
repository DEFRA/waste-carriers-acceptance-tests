require_relative "sections/govuk_banner.rb"

class UsersPage < SitePrism::Page

  section(:govuk_banner, GovukBanner, GovukBanner::SELECTOR)

  element(:migrate_users, "a[href='/bo/users/migrate']")

end
