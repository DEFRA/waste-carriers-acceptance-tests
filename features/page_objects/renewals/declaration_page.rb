class DeclarationPage < SitePrism::Page

  element(:declaration, "#registration_declaration")

  element(:submit_button, "input[type='submit']")

  def submit(_args = {})
    submit_button.click
  end

end
