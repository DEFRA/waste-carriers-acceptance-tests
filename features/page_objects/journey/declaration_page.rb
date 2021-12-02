class DeclarationPage < BasePage

  # Declaration

  element(:error_summary, ".govuk-error-summary__body")
  element(:heading, "h1")

  element(:declaration, "#declaration-form-declaration-1-field , .govuk-checkboxes__label")
  element(:submit_button, "[type='submit']")

  def submit(_args = {})
    declaration.click
    submit_button.click
  end

end
