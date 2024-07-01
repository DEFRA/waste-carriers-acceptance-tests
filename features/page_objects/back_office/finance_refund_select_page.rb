class FinanceRefundSelectPage < BasePage

  # Which payment do you want to refund?

  section(:govuk_banner, GovukBanner, GovukBanner::SELECTOR)

  elements(:refund_links, "a[href*='refund/']")

end
