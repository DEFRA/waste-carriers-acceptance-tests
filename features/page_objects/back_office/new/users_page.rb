require_relative "sections/govuk_banner.rb"

class UsersPage < SitePrism::Page
  set_url "#{Quke::Quke.config.custom['urls']['back_office_renewals']}/bo/users"

  section(:govuk_banner, GovukBanner, GovukBanner::SELECTOR)

  element(:migrate_users, "a[href='/bo/users/migrate']")
  element(:invite_user, "a[href='/bo/users/invitation/new']")
end
