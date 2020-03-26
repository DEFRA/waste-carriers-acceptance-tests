class RegistrationEditPaymentSummaryPage < SitePrism::Page
  section(:govuk_banner, GovukBanner, GovukBanner::SELECTOR)

  element(:card_payment_method_radio, "#edit_payment_summary_form_temp_payment_method_card", visible: false)
  element(
    :bank_transfer_payment_method_radio,
    "#edit_payment_summary_form_temp_payment_method_bank_transfer",
    visible: false
  )

  element(:submit_form, "input[type='submit']")
end
