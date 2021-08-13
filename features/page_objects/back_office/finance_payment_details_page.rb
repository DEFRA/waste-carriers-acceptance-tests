class FinancePaymentDetailsPage < SitePrism::Page

  # Payment details for CBDU1
  # Buttons on this page appear based on our user permissions table

  section(:govuk_banner, GovukBanner, GovukBanner::SELECTOR)

  element(:back_link, ".govuk-back-link")
  element(:heading, "h1")
  element(:flash_message, ".govuk-notification-banner__heading")

  element(:info_panel, ".wcr-panel-border-all")
  element(:business_name, ".wcr-panel-border-all .heading-medium")

  element(:enter_payment_button, "a[href$='/payments']")
  element(:reverse_payment_button, "a[href*='/reversals']")
  element(:write_off_button, "a[href*='/write-off']")
  element(:charge_adjust_button, "a[href*='/charge-adjusts']")
  element(:refund_button, "a[href*='/refund']")
  element(:balance, ".govuk-table__cell--numeric:nth-child(2)")

  # Sample text on this page:
  # Payment details for CBDU6
  # AD UT Company limited
  # Upper tier - Carrier, broker and dealer
  #
  # ENVIRONMENT AGENCY, DEANERY ROAD, BRISTOL, BS1 5AH
  #
  # Payment required
  # GBP159 to pay
  #
  # Charges and amendments
  # Date Charge Amount in GBP
  # 21/02/2020 09:08 Initial Registration 154.00
  # 21/02/2020 09:08 1x Copy cards 5.00
  # Payment history
  # Date Method Reference Comment Amount in GBP
  # Balance
  # Status Amount in GBP
  # Payment required 159.00

end
