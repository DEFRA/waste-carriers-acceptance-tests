require_relative "sections/govuk_banner.rb"

class TransientRegistrationsPage < SitePrism::Page

  section(:govuk_banner, GovukBanner, GovukBanner::SELECTOR)

  elements(:continue_as_assisted_digital, "a[href*='/bo/renew']")
  element(:process_payment, "a[href*='/transient_payments']")
  element(:check_convictions, "a[href*='/convictions']:nth-child(1)")
end
