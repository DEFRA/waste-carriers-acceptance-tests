class RefundCompletePage < SitePrism::Page

  # Refund complete

  element(:payment_status, "a[href*='paymentstatus']")

end
