class FinanceReversalSelectPage < BasePage

  # Which payment do you want to reverse?

  section(:govuk_banner, GovukBanner, GovukBanner::SELECTOR)

  elements(:reverse_links, "a[href*='/reversals/']")

end
