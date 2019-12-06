require_relative "sections/govuk_banner.rb"

class ConvictionsDashboardPage < SitePrism::Page

  # This page is not currently called

  section(:govuk_banner, GovukBanner, GovukBanner::SELECTOR)

end
