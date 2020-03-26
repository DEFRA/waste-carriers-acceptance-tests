class RegistrationEditCompletedPage < SitePrism::Page
  section(:govuk_banner, GovukBanner, GovukBanner::SELECTOR)

  element(:view_registration, :link, "View registration")
end
