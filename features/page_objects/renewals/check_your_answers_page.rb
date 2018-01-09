class CheckYourAnswersPage < SitePrism::Page

  # Check your details before registering
  element(:edit_smart_answers, "#changeSmartAnswers")
  element(:edit_registration_type, "#changeRegistrationType")
  element(:edit_key_people, "#edit_key_person")

  element(:submit_button, "input[type='Submit']")

  def submit(_args = {})
    submit_button.click
  end

end
