require_relative "sections/govuk_banner"

class UserDeactivatePage < SitePrism::Page
  section(:govuk_banner, GovukBanner, GovukBanner::SELECTOR)

  element(:submit_field, "[type='submit']")
end
