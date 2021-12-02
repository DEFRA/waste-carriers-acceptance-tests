require_relative "sections/govuk_banner"

class UserAcceptInvitePage < BasePage
  section(:govuk_banner, GovukBanner, GovukBanner::SELECTOR)

  element(:password_field, "#user_password")
  element(:confirm_password_field, "#user_password_confirmation")

end
