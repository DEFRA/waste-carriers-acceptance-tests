class FinanceReversalSelectPage < SitePrism::Page

  # Which payment do you want to reverse?

  section(:govuk_banner, GovukBanner, GovukBanner::SELECTOR)

  element(:back_link, ".link-back")
  element(:heading, ".heading-large")
  element(:content, "#content")

  elements(:reverse_links, "a[href*='/reversals/']")

end
