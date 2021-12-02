require_relative "sections/govuk_banner"

class UsersPage < BasePage
  set_url "#{Quke::Quke.config.custom['urls']['back_office']}/users"

  section(:govuk_banner, GovukBanner, GovukBanner::SELECTOR)

  element(:migrate_users, "a[href='/bo/users/migrate']")
  element(:invite_user, "a[href='/bo/users/invitation/new']")
end
