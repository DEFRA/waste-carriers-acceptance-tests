class EditConfirmCancelPage < SitePrism::Page
  section(:govuk_banner, GovukBanner, GovukBanner::SELECTOR)

  element(:confirm_cancel, "input[type='submit']")
end
