require_relative "sections/govuk_banner.rb"

class ConvictionsDashboardPage < SitePrism::Page

  section(:govuk_banner, GovukBanner, GovukBanner::SELECTOR)

end
