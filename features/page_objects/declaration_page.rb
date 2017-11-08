class DeclarationPage < SitePrism::Page

  # Check your details before registering

  element(:edit_registration_type, "#changeRegistrationType")
  element(:edit_key_people, "#edit_key_person")

  element(:declaration, "#registration_declaration")

  element(:submit_button, "input[type='Submit']")

  def submit(_args = {})
    declaration.click
    submit_button.click
  end

end
