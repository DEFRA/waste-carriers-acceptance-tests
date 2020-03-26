class RegistrationEditPayByBankTransferPage < SitePrism::Page
  section(:govuk_banner, GovukBanner, GovukBanner::SELECTOR)

  element(:submit_form, "input[type='submit']")
end
