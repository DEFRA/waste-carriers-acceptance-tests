require_relative "sections/govuk_banner"

class UserAmendPage < SitePrism::Page
  section(:govuk_banner, GovukBanner, GovukBanner::SELECTOR)

  element(:submit_field, "[type='submit']")

  element(:agency_with_refund_user_radio, "input[value='agency_with_refund']", visible: false)
end
