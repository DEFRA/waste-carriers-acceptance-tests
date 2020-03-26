class RegistrationEditContactEmailPage < SitePrism::Page
  section(:govuk_banner, GovukBanner, GovukBanner::SELECTOR)

  element(:contact_email_field, "#contact_email_form_contact_email")
  element(:confirm_contact_email_field, "#contact_email_form_confirmed_email")
  element(:submit_form, "input[type='submit']")
end
