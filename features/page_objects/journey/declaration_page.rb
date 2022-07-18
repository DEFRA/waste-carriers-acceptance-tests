class DeclarationPage < BasePage

  # Declaration

  element(:declaration, "#declaration-form-declaration-1-field", visible: false)

  def submit(_args = {})
    declaration.click
    submit_button.click
  end

end
