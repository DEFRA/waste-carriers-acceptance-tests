class FinishAssistedPage < SitePrism::Page

  # Registration complete / Registration pending
  element(:heading, ".heading-large")
  element(:registration_number, "#registrationNumber")
  element(:access_code, "#accessCode")
  element(:view_certificate, "#view_certificate")

  element(:submit_button, "#finished_btn")

  def submit(_args = {})
    submit_button.click
  end

end
