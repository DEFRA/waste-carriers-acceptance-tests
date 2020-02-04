class RenewalCompletePage < SitePrism::Page

  # Registration complete
  element(:confirmation_box, ".govuk-box-highlight")
  element(:heading, ".heading-xlarge")

  element(:finished_button, ".button")

end
