require_relative "sections/govuk_banner.rb"

class ConvictionsPage < SitePrism::Page

  section(:govuk_banner, GovukBanner, GovukBanner::SELECTOR)

  element(:approve, "a[href$='/approve']")
  element(:reject, "a[href$='/reject']")

end
