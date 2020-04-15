class ConfirmationPage < SitePrism::Page

  # Registration complete
  element(:confirmation_message, ".completeSummaryTitle")
  element(:registration_number, "#registrationNumber")

end
