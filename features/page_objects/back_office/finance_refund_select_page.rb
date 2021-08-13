class FinanceRefundSelectPage < SitePrism::Page

  # Which payment do you want to refund?

  section(:govuk_banner, GovukBanner, GovukBanner::SELECTOR)

  element(:back_link, ".govuk-back-link")
  element(:heading, "h1")
  element(:content, "#main-content")

  elements(:refund_links, "a[href*='/refunds/']")

end
