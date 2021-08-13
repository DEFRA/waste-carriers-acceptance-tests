class FinanceReversalSelectPage < SitePrism::Page

  # Which payment do you want to reverse?

  section(:govuk_banner, GovukBanner, GovukBanner::SELECTOR)

  element(:back_link, ".govuk-back-link")
  element(:heading, "h1")
  element(:content, "#main-content")

  elements(:reverse_links, "a[href*='/reversals/']")

end
