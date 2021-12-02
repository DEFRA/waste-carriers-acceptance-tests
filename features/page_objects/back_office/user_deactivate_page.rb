require_relative "sections/govuk_banner"

class UserDeactivatePage < BasePage
  section(:govuk_banner, GovukBanner, GovukBanner::SELECTOR)

end
