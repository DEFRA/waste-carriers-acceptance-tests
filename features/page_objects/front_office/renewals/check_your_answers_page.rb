class CheckYourAnswersPage < SitePrism::Page

  # Check your details before registering
  element(:edit_smart_answers, "#changeSmartAnswers")
  element(:edit_registration_type, "#changeRegistrationType")
  element(:edit_key_people, "#edit_key_person")
  element(:heading, :xpath, "//h1[contains(text(), 'Check your details')]")
  element(:submit_button, "input[type='submit']")

  def submit(_args = {})
    wait_for_heading
    submit_button.click
  end

end