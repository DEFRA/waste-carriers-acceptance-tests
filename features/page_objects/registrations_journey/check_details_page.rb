# frozen_string_literal: true

class CheckDetailsPage < SitePrism::Page

  # Check your details before registering
  element(:edit_smart_answers, "#changeSmartAnswers")
  element(:edit_registration_type, "#changeRegistrationType")
  element(:edit_key_people, "#edit_key_person")
  element(:declaration, "#registration_declaration")

  element(:submit_button, "#confirm")

  def submit(args = {})
    declaration.click if args[:declaration] == true

    submit_button.click
  end

end
