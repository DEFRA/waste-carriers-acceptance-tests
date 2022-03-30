class DeclarationPage < BasePage

  # Declaration

  element(:declaration, "#declaration-form-declaration-1-field , .govuk-checkboxes__label")

  def submit(_args = {})
    declaration.click
    submit_button.click
  end

end
