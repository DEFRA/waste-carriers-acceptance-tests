class FinishAssistedPage < SitePrism::Page

  # Registration complete
  element(:registration_number, "#registrationNumber")
  element(:access_code, "#accessCode")
  element(:view_certificate, "#view_certificate")

end