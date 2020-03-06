class RefundsPage < SitePrism::Page

  # Select a payment to refund

  element(:refund, "a[href*='worldpayRefund']")

end
