class FinancePaymentDetailsPage < BasePage

  # Payment details for CBDU1
  # Buttons on this page appear based on our user permissions table

  section(:govuk_banner, GovukBanner, GovukBanner::SELECTOR)

  element(:info_panel, ".wcr-panel-border-all")
  element(:business_name, ".wcr-panel-border-all .heading-medium")

  element(:enter_payment_button, "a[href$='/payments']")
  element(:reverse_payment_button, "a[href*='/reversals']")
  element(:write_off_button, "a[href*='/write-off']")
  element(:charge_adjust_button, "a[href*='/charge-adjusts']")
  element(:refund_button, "a[href*='/refund']")
  element(:refund_bank_transfer, "a[href$='record-bank-transfer-refund']")
  element(:check_refund_status, "a[href*='/refunds/']")
  element(:balance, ".govuk-table__cell--numeric:nth-child(2)")

  def check_balance?(value)
    10.times do
      return true if balance.text == value

      sleep 1
      page.evaluate_script "window.location.reload()"
    end
    puts "Balance is #{balance.text}, expected #{value}"
    false
  end

end
