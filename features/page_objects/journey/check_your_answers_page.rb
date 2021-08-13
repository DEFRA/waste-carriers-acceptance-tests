class CheckYourAnswersPage < SitePrism::Page

  # Check your answers before renewing your registration
  element(:heading, ".heading_large")

  # Question: do these get called for renewals?
  element(:edit_smart_answers, "#changeSmartAnswers")
  element(:edit_registration_type, "#changeRegistrationType")
  element(:edit_key_people, "#edit_key_person")
  element(:submit_button, "[type='submit']")

  def submit(_args = {})
    submit_button.click
  end

end
