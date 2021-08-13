class EditPage < SitePrism::Page
  section(:govuk_banner, GovukBanner, GovukBanner::SELECTOR)

  element(:change_contact_email, "a[href$='contact-email']")
  element(:change_registration_type, "a[href$='cbd-type']")

  element(:confirm_changes, "[type='submit']", match: :first)
  element(:cancel_changes, "a[href$='confirm-edit-cancelled']", match: :first)
end
