# frozen_string_literal: true

class ConfirmationPage < SitePrism::Page

  # Covers all "registration/renewal complete" scenarios

  element(:confirmation_box, ".govuk-box-highlight")
  element(:heading, ".heading-xlarge")
  element(:content, "#content")

  element(:registration_number, "#reg_identifier")
  element(:finished_button, ".button")
end
