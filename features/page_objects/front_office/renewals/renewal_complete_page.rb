class RenewalCompletePage < SitePrism::Page

  # Registration complete
  element(:confirmation_box, ".govuk-box-highlight")
  element(:heading, :xpath, "//h1[contains(text(), 'Renewal complete')]")

  element(:finished, "a[href$='/registrations']")

end
