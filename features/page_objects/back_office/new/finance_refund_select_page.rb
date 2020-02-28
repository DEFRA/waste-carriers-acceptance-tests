class FinanceRefundSelectPage < SitePrism::Page

  # Which payment do you want to refund?

  section(:govuk_banner, GovukBanner, GovukBanner::SELECTOR)

  element(:back_link, ".link-back")
  element(:heading, ".heading-large")
  element(:content, "#content")

  elements(:refund_links, "a[href*='/refunds/']")

end
