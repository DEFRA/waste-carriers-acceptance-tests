require_relative "sections/govuk_banner"

class UserAmendPage < BasePage
  section(:govuk_banner, GovukBanner, GovukBanner::SELECTOR)

  element(:agency_with_refund_user_radio, "input[value='agency_with_refund']", visible: false)
end
