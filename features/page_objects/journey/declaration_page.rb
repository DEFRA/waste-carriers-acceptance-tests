class DeclarationPage < SitePrism::Page

  # Declaration

  element(:error_summary, ".govuk-error-summary__body")
  element(:heading, "h1")

  element(:declaration, "input[id^='declaration-form-declaration']", visible: false)
  element(:submit_button, "[type='submit']")

  def submit(_args = {})
    declaration.click
    submit_button.click
  end

end
