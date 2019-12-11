class DeclarationPage < SitePrism::Page

  # Declaration

  element(:heading, ".heading-large")
  element(:declaration, "#declaration_form_declaration", visible: false)
  element(:submit_button, "input[type='submit']")

  def submit(_args = {})
    declaration.click
    submit_button.click
  end

end
