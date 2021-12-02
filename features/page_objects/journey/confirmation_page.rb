# frozen_string_literal: true

class ConfirmationPage < BasePage

  # Covers all "registration/renewal complete" scenarios

  element(:confirmation_box, ".govuk-box-highlight")
  element(:heading, "h1")
  element(:content, "#main-content")

  element(:registration_number, "#reg_identifier")

  element(:finished_button, "a[class='govuk-button']")
end
