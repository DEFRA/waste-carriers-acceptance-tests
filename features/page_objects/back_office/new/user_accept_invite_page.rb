require_relative "sections/govuk_banner.rb"

class UserAcceptInvitePage < SitePrism::Page
  section(:govuk_banner, GovukBanner, GovukBanner::SELECTOR)

  element :password_field, '#user_password'
  element :confirm_password_field, '#user_password_confirmation'

  element :submit_field, 'input[type="submit"]'
end
